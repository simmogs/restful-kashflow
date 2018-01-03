require_relative './base_service'

module RestfulKashflow
  module Services
    class Customer < BaseService
      def initialize(api_service, customer_id)
        @url = "/customers/#{customer_id}"
        @api_service = api_service

        call_url

        @customer = JSON.parse(@response.body)
      end

      def has_signed_mandate?
        !!@customer["IsGoCardlessMandateSet"]
      end
    end
  end
end
