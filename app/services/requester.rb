class Requester
  class << self
    def make_request http_verb, url, headers, body = {}
      headers = default_headers(http_verb).merge! headers
      response = validate_response do
        HTTParty.send(http_verb, url, headers: headers, body: body)
      end
      format_response response
    rescue => excp
      args = build_args http_verb, url, headers, body
      log_and_notify args, excp
      error_msg_for_exception excp
    end

    private

    def default_headers http_verb
      if http_verb.downcase == "get"
        { "Content-Type" => "application/json" }
      else
        Hash.new
      end
    end

    def build_args http_verb, url, headers, body
      {
        url: url,
        headers: headers,
        body: body,
        method: http_verb,
        error_class: "ApiRequester"
      }
    end

    def error_msg_for_exception excp
      if excp.class.to_s == "ServiceResponseError"
        message = JSON.parse(excp.message)
        { status: message["code"], body: message["body"] }
      else
        { status: 500, body: { message: "Internal Server Error" } }
      end
    end

    def format_response response
      {
        status: response.code,
        body: JSON.parse(response.body),
        headers: response.headers
      }
    end

    def log_and_notify args, exception=nil
      Rails.logger.error(class: args[:error_class],
                         url: args[:url],
                         method: args[:method],
                         body: args[:body],
                         headers: args[:headers],
                         error: exception,
                         timestamp: Time.now.utc)
    end

    def validate_response
      response = yield
      code = response.code.to_i
      body = response.body
      unless success_code? code
        message = {
          code: code,
          body: JSON.parse(body)
        }.to_json
        raise ServiceResponseError, message
      end

      response
    end

    def success_code? code
      (200..209).cover? code
    end
  end
end
