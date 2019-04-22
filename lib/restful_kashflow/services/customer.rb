require_relative "./base_service"

module RestfulKashflow
  module Services
    class Customer < BaseService
      def initialize(api_service, customer_id)
        @url = "/customers/#{customer_id}"
        @api_service = api_service

        response = Customer.call_url(@api_service, @url)

        @customer = JSON.parse(response.body)
      end

      def has_signed_mandate?
        !!@customer["IsGoCardlessMandateSet"]
      end

      def raw
        @customer.dup
      end

      def self.create(api_service, name, email, first_name, last_name)
        url = "/customers"

        body = {
          "name": name,
          "contacts": [
            {
              "email": email,
              "firstname": first_name,
              "lastname": last_name,
            },
          ],
        }.to_json

        response = call_url(api_service, url, "post", body)

        @customer = JSON.parse(response.body)
      end

      def self.get_mandate(api_service:, code:)
        url = "/customers/#{code}/mandates"

        response = call_url(api_service, url, "get")

        @customer_mandate = JSON.parse(response.body)
      end

      def self.create_mandate(api_service:, code:, email:)
        url = "/customers/#{code}/mandates"

        body = {
          "Amount": 2000,
          "Email": {
            "To": email,
            "Subject": "Butterware Direct Debit Mandate",
            "Body": "Butterware Direct Debit Mandate",
            "IsHtml": true,
            "SenderAddress": "accounts@butterware.co.uk",
            "SenderName": "Butterware",
          },
          "Description": "Butterware Direct Debit Mandate",
          "AmountValidity": "Monthly",
          "CustomerCode": code,
        }.to_json

        response = call_url(api_service, url, "post", body)

        @customer_mandate = JSON.parse(response.body)
      end
    end
  end
end
