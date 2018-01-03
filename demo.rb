require_relative 'lib/restful_kashflow'

creds = {
  username: 'username',
  password: 'password',
  memorable_word: 'memorable_word'
}

client = RestfulKashflow::Client.new(
  username: creds[:username],
  password: creds[:password],
  memorable_word: creds[:memorable_word],
  environment: :live
)

puts client.customer('CUST01').has_signed_mandate?
puts client.customer('CUST02').has_signed_mandate?
