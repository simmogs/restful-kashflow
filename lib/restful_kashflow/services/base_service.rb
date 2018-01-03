module RestfulKashflow
  module Services
    class BaseService

      private

      def call_url
        session_id = @api_service.session_token
        full_url = "#{@api_service.url}#{@url}"

        puts "Calling #{full_url}"

        @response = RestClient.get full_url,
                                    {
                                      content_type: :json,
                                      accept: :json,
                                      Authorization: "KfToken #{session_id}"
                                    }
      end
    end
  end
end
