require 'spec_helper'

describe Zarinpal::Response do
  let(:response) { Zarinpal::Response.new }

  before(:all) do
    Zarinpal.configure do |config|
      config.merchant_id = 'XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX'
      config.callback_url = 'http://example.com/callback_url'
    end
  end

  it 'responses to authority and status' do
    expect(response).to respond_to :authority
    expect(response).to respond_to :status
  end

  context 'Validation' do
    it 'fails validation if response is nil' do
      zarin = Zarinpal::Response.new
      expect{ zarin.validate }.to raise_error(ArgumentError, 'not a valid response')
    end

    it 'fails if status is less than 0' do
      response = { payment_request_response: { status: "-2" } }
      zarin = Zarinpal::Response.new
      expect { zarin.validate(response) }.to raise_error(Zarinpal::Response::ResponseError, 'IP or Merchant Code is not correct')
      expect(zarin).to_not be_valid
    end

    it 'fails if authority is less than 36 character' do
      pending 'do we need to check for length of authority?'
      response = { payment_request_response: {authority: "this-is-wrong"} }
      zarin = Zarinpal::Response.new
      expect{ zarin.validate(response) }.to raise_error(Zarinpal::Response::ResponseError)
    end

    it 'is successful' do
      response = { payment_request_response: {authority: "x" * 36, status: '100' } }
      zarin = Zarinpal::Response.new.validate response

      expect(zarin).to be_valid
      expect(zarin.authority).to eq("x" * 36)
    end
  end

end
