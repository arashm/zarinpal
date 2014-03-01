require 'spec_helper'

describe Zarinpal::PaymentRequest do
  include Savon::SpecHelper

  let(:zarin) {
    Zarinpal::PaymentRequest.new(
    {
      amount: 10000,
      description: 'sth for test'
    })
  }

  let(:uri) { 'https://de.zarinpal.com/pg/services/WebGate/wsdl' }

  before(:all) do
    savon.mock!

    Zarinpal.configure do |config|
      config.merchant_id = 'XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX'
      config.callback_url = 'http://example.com/callback_url'
    end
  end

  after(:all) { savon.unmock! }

  it 'responses to call' do
    expect(zarin).to respond_to(:call)
  end

  it 'successfully calls the server' do
    message = {"MerchantID"=>"52fbc7f4-3ca4-4b40-88ee-287f5ee8a9d4", "Amount"=>10000, "Description"=>"sth for test", "Email"=>"", "Mobile"=>"", "CallbackURL"=>"http://example.com/callback_url"}

    savon.expects(:payment_request).with(message: message ).returns('<SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns1="http://zarinpal.com/"><SOAP-ENV:Body><ns1:PaymentRequestResponse><ns1:Status>101</ns1:Status><ns1:Authority>"xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"</ns1:Authority></ns1:PaymentRequestResponse></SOAP-ENV:Body></SOAP-ENV:Envelope>')

    response = zarin.call
    expect(response).to be_valid
  end

end
