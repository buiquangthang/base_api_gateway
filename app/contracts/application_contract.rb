require 'dry/schema/messages/i18n'

module Contracts
  class ApplicationContract < Dry::Validation::Contract
    config.messages.load_paths << 'config/locales/dry_validation.en.yml'
    config.messages.default_locale = :en
    config.messages.backend = :i18n

    def self.call(*args, &block)
      new.call(*args, &block)
    end
  end
end
