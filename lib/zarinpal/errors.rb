module Zarinpal
  # List of status code errors and description
  module Errors
    # List of status code errors and description
    IDS = {
      '-1'  => 'Insufficient information',
      '-2'  => 'IP or Merchant Code is not correct',
      '-3'  => 'Amount should be greater than 1000',
      '-4'  => 'Insufficient',
      '-11' => 'Requested response didn\'t find',
      '-21' => 'No financial action found for this transaction',
      '-22' => 'Unsuccessful transaction',
      '-33' => 'Transaction price is not equal to payed amount',
      '-54' => 'The request had archived'
    }
  end
end
