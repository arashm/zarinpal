require 'spec_helper'

describe Zarinpal do
  before do
    Zarinpal.configure do |config|
      config.merchant_id = '52fbc7f4-3ca4-4b40-88ee-287f5ee8a9d4'
      config.callback_url = 'http://www.m0b.ir/verify.php'
    end
  end

  it 'responses to merchant_id' do
    expect(Zarinpal.configuration.merchant_id).to eq('52fbc7f4-3ca4-4b40-88ee-287f5ee8a9d4')
  end

  it 'responses to client with default value' do
    expect(Zarinpal.configuration.client).to eq('https://de.zarinpal.com/pg/services/WebGate/wsdl')
  end
end
