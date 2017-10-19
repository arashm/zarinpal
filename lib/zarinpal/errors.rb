# frozen_string_literal: true

module Zarinpal
  # List of status code errors and description
  module Errors
    # List of status code errors and description
    IDS = {
      '-1'  => 'Insufficient information',
      '-2'  => 'IP or Merchant Code is not correct',
      '-3'  => 'Amount should be greater than 1000 IRR',
      '-4'  => 'The verification level should be above silver',
      '-11' => 'Couldn\'t find the requested payment',
      '-21' => 'No financial action found for this transaction',
      '-22' => 'Unsuccessful transaction',
      '-33' => 'Transaction amount is not equal to payed amount',
      '-54' => 'The payment request has been archived',
    }.freeze
  end
end
