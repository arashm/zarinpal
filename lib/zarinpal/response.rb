# frozen_string_literal: true

module Zarinpal
  # This class manages the returned response from PaymentVerification and
  # PaymentRequest. If the response is not valid (the status is not code is 100 or 101)
  # it will raise an error with the corresponding description.
  class Response
    class ResponseError < RuntimeError; end

    attr_reader :response, :authority, :status, :refid

    # Checks if the transaction response returned from PaymentRequest
    # or PaymentVerification is valid
    #
    # @param [#response Hash]
    # @raise [ArgumentError] if response is nil
    # @raise [ResponseError] if response is not valid
    # @return [Response]
    def validate(response = nil)
      @response = response
      perform_validation

      self
    end

    # Returns the validation status of response
    #
    # @return [boolean]
    def valid?
      @valid
    end

  private

    def perform_validation
      raise ArgumentError, 'not a valid response' if @response.nil?

      body       = @response[:payment_request_response] || @response[:payment_verification_response]
      @authority = body[:authority]
      @status    = body[:status].to_i
      @refid     = body[:ref_id]

      if !%w(100 101).include?(body[:status])
        @valid = false
        raise ResponseError, Errors::IDS[body[:status]]
      else
        @valid = true
      end
    end
  end
end
