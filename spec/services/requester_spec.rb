# frozen_string_literal: true

RSpec.describe Requester, type: :service do
  describe '.make_request' do
    let(:http_verb) { 'GET' }
    let(:url) { 'http://example.com/api/resource' }
    let(:headers) { { 'Authorization' => 'Bearer token123', 'Content-Type' => 'application/json' } }
    let(:body) { { key: 'value' } }

    context 'when the request is successful' do
      let(:response_body) { { 'data' => 'value' }.to_json }
      let(:successful_response) { instance_double(HTTParty::Response, code: 200, body: response_body, headers: {}) }

      it 'makes a request with the correct parameters' do
        allow(HTTParty).to receive(:send).and_return(successful_response)

        result = described_class.make_request(http_verb, url, headers, body)

        expect(HTTParty).to have_received(:send).with(http_verb, url, headers:, body:)
        expect(result).to eq(
          status: 200,
          body: JSON.parse(response_body),
          headers: successful_response.headers
        )
      end
    end

    context 'when the request is unsuccessful' do
      let(:error_response_body) { { 'error' => 'Bad Request' }.to_json }
      let(:unsuccessful_response) do
        instance_double(HTTParty::Response, code: 400, body: error_response_body, headers: {})
      end

      it 'raises a ServiceResponseError with the error details' do
        allow(HTTParty).to receive(:send).and_return(unsuccessful_response)

        expect(described_class.make_request(http_verb, url, headers, body)).to eq(
          { status: 400, body: JSON.parse(error_response_body) }
        )
      end
    end

    context 'when an exception occurs during the request' do
      let(:exception) { StandardError.new('Some error') }

      it 'logs and notifies the exception' do
        allow(HTTParty).to receive(:send).and_raise(exception)
        allow(Rails.logger).to receive(:error)

        expect(described_class.make_request(http_verb, url, headers, body)).to eq(
          { status: 500, body: { message: 'Internal Server Error' } }
        )

        expect(Rails.logger).to have_received(:error).with(hash_including(error: exception))
      end
    end
  end
end
