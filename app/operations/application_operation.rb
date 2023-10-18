require 'dry/monads'
require 'dry/monads/do'

module Operations
  class ApplicationOperation
    def self.call(*args, &block)
      new.call(*args, &block)
    end
  end
end
