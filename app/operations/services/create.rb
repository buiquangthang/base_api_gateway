module Operations
  module Services
    class Create < ApplicationOperation
      include Dry::Monads[:result, :do]

      def call(params)
        valid_input = yield validate(params)

        service = yield create_service(valid_input)

        Success(service)
      end

      private

      def validate(input)
        result = Contracts::NewServiceContract.call(input)

        return Failure(result.errors(full: true).messages) unless result.success?

        Success(input)
      end

      def create_service(valid_input)
        service = Service.create!(valid_input)

        Success(service)
      end
    end
  end
end
