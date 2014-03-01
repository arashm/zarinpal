require 'spec_helper'

describe Zarinpal::PaymentVerification, focus: true do
  include Savon::SpecHelper

  let(:pv) {
    Zarinpal::PaymentVerification.new(
    {
      authority: 'XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX',
      amount: 10000
    })
  }

  before(:all) do
    savon.mock!

    Zarinpal.configure do |config|
      config.merchant_id = '52fbc7f4-3ca4-4b40-88ee-287f5ee8a9d4'
    end
  end

  after(:all) { savon.unmock! }

  it 'successfully verify the request' do
    message = {"MerchantID"=>"52fbc7f4-3ca4-4b40-88ee-287f5ee8a9d4", "Authority"=>'XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX', "Amount"=>10000}

    savon.expects(:payment_verification).with(message: message ).returns('<SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ns1="http://zarinpal.com/">
      <SOAP-ENV:Body>
        <ns1:PaymentVerificationResponse>
          <ns1:Status>100</ns1:Status>
          <ns1:RefID>22xxff33</ns1:RefID>
        </ns1:PaymentVerificationResponse>
      </SOAP-ENV:Body>
    </SOAP-ENV:Envelope>')

    response = pv.verify
    expect(response).to be_valid
    expect(response.refid).to eq('22xxff33')
    expect(response.status).to eq(100)
  end
end
