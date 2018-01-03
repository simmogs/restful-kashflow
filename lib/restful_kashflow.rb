require 'json'
require 'zlib'
require 'rest-client'
require 'time'

require 'uri'

module RestfulKashflow
end

version_file = 'restful_kashflow/version'

if File.file? File.expand_path("#{version_file}.rb", File.dirname(__FILE__))
  require_relative version_file
else
  RestfulKashflow::VERSION = ''.freeze
end

require_relative 'restful_kashflow/client'
require_relative 'restful_kashflow/api_service'
require_relative 'restful_kashflow/services/customer'
