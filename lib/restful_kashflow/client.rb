module RestfulKashflow
  # A class for working with and talking to the Kashflow API
  class Client

    def initialize(options)
      username = options.delete(:username) || raise('No username given to Restful Kashflow Client')
      password = options.delete(:password) || raise('No password given to Restful Kashflow Client')
      memorable_word = options.delete(:memorable_word) || raise('No memorable word given to Restful Kashflow Client')
      environment = options.delete(:environment) || :live
      @customer = {}

      url = options.delete(:url) || url_for_environment(environment)

      @api_service = ApiService.new(username,
                                    password,
                                    memorable_word,
                                    url,
                                    options)
    end

    def status
      @api_service.status
    end

    def customer(customer_id = nil)
      @customer[customer_id] ||= Services::Customer.new(@api_service, customer_id)
    end

    def new_customer(name: , email:, first_name:, last_name:)
      customer = Services::Customer.create(
        @api_service,
        name,
        email,
        first_name,
        last_name
      )

      puts pp customer
      puts customer.class
      puts customer.first
      puts customer["Code"]
      puts customer["Contacts"].first["Email"]

      puts mandate = Services::Customer.get_mandate(
        api_service: @api_service,
        code: customer["Code"]
      )

      mandate = Services::Customer.create_mandate(
        api_service: @api_service,
        code: customer["Code"],
        email: customer["Contacts"].first["Email"]
      )
      puts mandate
      return { customer: customer, mandate: mandate }
    end

    private

    def url_for_environment(environment)
      if environment === :live
        'https://api.kashflow.com/v2'
      elsif environment === :sandbox
        'https://api-sandbox.kashflow.com/v2'
      else
        raise "Unknown environment key: #{environment}"
      end
    end
  end
end
