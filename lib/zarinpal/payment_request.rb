# frozen_string_literal: true

require 'savon'

module Zarinpal
  # Sends a payment request to zarinpal
  #
  # @return [Zarinpal::Response]
  class PaymentRequest
    attr_accessor :amount, :description, :email, :mobile
    attr_reader   :response

    # @note A hash of parameters should be send to this class
    # @example
    #   PaymentRequest.new(amount: 10000, description: 'sth...', email: 'example@example.com')
    #
    # @param args [Hash] hash of params to send requests
    # @option args [Integer] :amount price of the request
    # @option args [Integer] :description description of transaction
    # @option args [String] :email ('') email of buyer
    # @option args [String] :mobile ('') mobile number of buyer
    def initialize(args = {})
      @amount      = args.fetch(:amount)
      @description = args.fetch(:description)
      @email       = args.fetch(:email, '')
      @mobile      = args.fetch(:mobile, '')
      @client      = Savon.client(wsdl: Zarinpal.configuration.client, pretty_print_xml: true)
      @response    = Response.new
    end

    # Sends the payment request to Zarinpal
    #
    # @return [Zarinpal::Response]
    def call
      response = @client.call :payment_request, message: {
        'MerchantID' => Zarinpal.configuration.merchant_id,
        'Amount' => @amount,
        'Description' => @description,
        'Email' => @email,
        'Mobile' => @mobile,
        'CallbackURL' => Zarinpal.configuration.callback_url,
      }

      @response.validate(response.body)
    end
  end
end
