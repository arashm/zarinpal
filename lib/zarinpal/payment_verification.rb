require "savon"

module Zarinpal
  # Verifyes transaction with Zarinpal
  class PaymentVerification
    attr_reader   :status, :refid

    # @note A hash of parameters should be send to this class
    # @example
    #   PaymentVerification.new(authority: 'xxx-xxx', amount: 10000)
    #
    # @param args [Hash] hash of params to verify transaction
    # @option args [String] :authority Authority code returned from PaymentRequest
    # @option args [Integer] :amount price of the request
    def initialize(args = {})
      @authority = args.fetch(:authority)
      @amount    = args.fetch(:amount)
      @client    = Savon.client(wsdl: Zarinpal.configuration.client, pretty_print_xml: true)
      @response  = Response.new
    end

    # Send verification request to Zarinpal
    #
    # @return [Zarinpal::Response]
    def verify
      response = @client.call :payment_verification, message: {
        'MerchantID' => Zarinpal.configuration.merchant_id,
        'Authority' => @authority,
        'Amount' => @amount
      }
      @response.validate(response.body)
    end
  end
end
