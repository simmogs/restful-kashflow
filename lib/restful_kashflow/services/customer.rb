require_relative './base_service'

module RestfulKashflow
  module Services
    class Customer < BaseService
      def initialize(api_service, customer_id)
        @url = "/customers/#{customer_id}"
        @api_service = api_service

        response = Customer::call_url(@api_service, @url)

        @customer = JSON.parse(response.body)
      end

      def has_signed_mandate?
        !!@customer["IsGoCardlessMandateSet"]
      end

      def self.create(api_service, name, email, first_name, last_name)
        url = "/customers"

        body = {
          "name": name,
          "contacts": [
            {
              "email": email,
              "firstname": first_name,
              "lastname": last_name
            }
          ]
        }.to_json

        response = call_url(api_service, url, 'post', body)

        @customer = JSON.parse(response.body)
      end

      def self.get_mandate(api_service:, code:)
        url = "/customers/#{code}/mandates"

        response = call_url(api_service, url, 'get')

        @customer_mandate = JSON.parse(response.body)
      end

      def self.create_mandate(api_service:, code:, email:)
        url = "/customers/#{code}/mandates"
        puts "URL : #{url}"

        body = {
          "amount": 2000,
          "title": "Butterware Direct Debit Mandate",
          "description": "Butterware Direct Debit Mandate",
          "EMailId": email,
          "amountvalidity": "Monthly"
        }.to_json

        puts body

        response = call_url(api_service, url, 'post', body)

        @customer_mandate = JSON.parse(response.body)
      end
    end
  end
end
