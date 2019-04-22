module RestfulKashflow
  module Services
    class BaseService
      private

      def self.call_url(api_service, url, method = "get", body = "")
        session_id = api_service.session_token
        full_url = "#{api_service.url}#{url}"

        puts "Calling #{full_url} with method #{method}"

        begin
          if method == "get"
            RestClient.get full_url,
              {
                content_type: :json,
                accept: :json,
                Authorization: "KfToken #{session_id}",
              }
          elsif method == "post"
            RestClient.post full_url, body,
              {
                content_type: :json,
                accept: :json,
                Authorization: "KfToken #{session_id}",
              }
          end
        rescue RestClient::ExceptionWithResponse => e
          puts e.response
          return nil
        end
      end
    end
  end
end
