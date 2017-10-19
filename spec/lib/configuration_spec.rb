require 'spec_helper'

describe Zarinpal do
  before do
    Zarinpal.configure do |config|
      config.merchant_id = 'XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX'
      config.callback_url = 'http://www.m0b.ir/verify.php'
    end
  end

  it 'responses to merchant_id' do
    expect(Zarinpal.configuration.merchant_id).to eq(
      'XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX'
    )
  end

  it 'responses to client with default value' do
    expect(Zarinpal.configuration.client).to eq(
      'https://de.zarinpal.com/pg/services/WebGate/wsdl'
    )
  end
end
