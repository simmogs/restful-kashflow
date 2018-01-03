require 'spec_helper'

describe RestfulKashflow::ApiService do
  subject(:service) { described_class.new('username',
                                          'password',
                                          'memorable_word',
                                          'https://api.example.com',
                                          options = {}) }

  let(:default_response) do
    {
      status: 200,
      body: '{}',
      headers: { 'Content-Type' => 'application/json' },
    }
  end

  it 'uses basic auth' do
    stub = stub_request(:get, 'https://api.example.com/customers').
           to_return(default_response)

    service.make_request(:get, '/customers')
    expect(stub).to have_been_requested
  end
end
