module Contracts
  class NewServiceContract < ApplicationContract
    params do
      required(:name).value(:string)
      required(:url).value(:string, format?: Regexes::SERVICE_URL)
      required(:token).value(:string)
    end
  end
end
