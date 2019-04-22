require "uri"
require "base64"

module RestfulKashflow
  class ApiService
    attr_reader :session_token, :url

    def initialize(username, password, memorable_word, url, options)
      @username = username
      @password = password
      @memorable_word = memorable_word
      @url = url
      @options = options

      # Send the username and password, returning a temporary token and
      # list of letters places to be extracted from the memorable word
      start_first_connection

      # Send the temporary token and letters from the memorable word, as
      # requested and get a permanent token in return.
      start_second_connection
    end

    private

    def start_first_connection
      puts "Starting first connection to Kashflow Restful API"
      response = RestClient.post "#{@url}/sessiontoken",
        username_and_password_hash.to_json,
        {
          content_type: :json,
          accept: :json,
        }
      hash = JSON.parse(response.body)

      @temporary_token = hash["TemporaryToken"]
      @word_list = hash["MemorableWordList"].inject([]) do |memo, a|
        memo << a["Position"]
      end
    end

    def start_second_connection
      puts "Starting second connection to Kashflow Restful API"
      response = RestClient.put "#{@url}/sessiontoken",
        generate_second_response.to_json,
        {
          content_type: :json,
          accept: :json,
        }
      hash = JSON.parse(response.body)

      @session_token = hash["SessionToken"]
    end

    def username_and_password_hash
      {
        "Password": @password,
        "UserName": @username,
      }
    end

    def generate_second_response
      {
        "TemporaryToken": @temporary_token,
        "MemorableWordList": memorable_word_list_hash,
      }
    end

    def memorable_word_list_hash
      @word_list.inject([]) do |memo, a|
        memo << {"Position": a, "Value": @memorable_word[a - 1]}
      end
    end
  end
end
