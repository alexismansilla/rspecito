require 'rails_helper'

describe Payment do
  it 'records the payment' do
    payment_gateway = double
    allow(payment_gateway).to receive(:charge).and_return(payment_id: 1234)

    logger = DummyLogger.new

    payment = Payment.new(payment_gateway, logger)
    payment.total_cents = 1800
    payment.save
  end
end
