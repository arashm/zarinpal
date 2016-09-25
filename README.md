# Zarinpal

A gem to to send and verify payments with [Zarinpal](http://zarinpal.com). Zarinpal is an Iranian provider. 

[![Code Climate](https://codeclimate.com/github/arashm/zarinpal.png)](https://codeclimate.com/github/arashm/zarinpal)
[![Build Status](https://travis-ci.org/arashm/zarinpal.png?branch=master)](https://travis-ci.org/arashm/zarinpal)

## Installation

Add this line to your application's Gemfile:

    gem 'zarinpal'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install zarinpal

## Usage

Here is a summery of how a transaction happens in Zarinpal:

### Workflow of a transaction

1) You have to send a payment request to Zarinpal server with needed information of the payment:

| Argument      | Type          | Needed  | Description |
| ------------- |:-------------:| :-----: | ----------- |
| MerchantId      | String | Yes | The private code you get from Zarinpal
| Amount      | Int | Yes | The price
| Description      | String | Yes | Description of transaction
| Email      | String | No | Email of buyer
| Mobile      | String | No | Mobile phone number of buyer
| CallbackURL      | String | Yes | The URL that Zarinpal redirects buyer after transaction

2) Your payment request will return an Authority and Status code from Zarinpal, if codes are correct, you have to send the buyer to Zarinpal gateway. URLs looks like this:

```
‫‪https://www.zarinpal.com/pg/StartPay/$Authority‬‬
‫‪https://www.zarinpal.com/pg/StartPay/$Authority/ZarinGate‬‬
```

3) Zarinpal will redirects user to the provided callback url with the Authority code as a QueryString. You have yo send a Payment Verification request to Zarinpal to check if the payment was successful or not. Payment verification needs `MerchantID`, `Authority` and `Amount`. Pyment verification will return a Status and RefID code. RefID is the dedicated code to the transaction.

### Coding
Configuring the gem:

```ruby
Zarinpal.configure do |config|
  # You have to get merchand_id from zarinpal website
  config.merchant_id  = 'XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX'
  config.callback_url = 'http://www.example.com/callback'
  # This is the default option. You don't need to mention it explicitly.
  config.client       = 'https://de.zarinpal.com/pg/services/WebGate/wsdl'
end
```

Sending payment request:

```ruby
payment_request = Zarinpal::PaymentRequest.new({
    amount: 10000,
    description: 'Sth cool',
    email: 'example@example.com',
    mobile: '09XXXXXXX'
})

# Returns a Zarinpal::Response object if transaction is successful or raises 
# a ResponseError if it fails
response = payment_request.call

response.authority  # authority returned by Zarinpal
response.status     # The status code returned by Zarinpal
response.valid?     # True or False
```

Sending payment verification request:

```ruby
payment_verification = Zarinpal::PaymentVerification.new({
  authority: 'XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX',
  amount: 10000
})

# Returns a Zarinpal::Response object if transaction is successful or raises 
# a ResponseError if it fails
response = payment_verification.verify

response.status     # The status code returned by Zarinpal
response.valid?     # True or False
response.refid      # RefID returned by Zarinpal
```

## Contributing

1. Fork it ( http://github.com/arashm/zarinpal/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
