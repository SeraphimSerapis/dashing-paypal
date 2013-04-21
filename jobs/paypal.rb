require 'paypal-sdk-rest'

include PayPal::SDK::REST

SCHEDULER.every '2m' do
  payments =  Hash.new({ amount: '0.00 USD', email: '', state: '', created: '' });
  history = Payment.all(:count => 5)
  
  history.payments.each do |payment|
    amount = 0;
    currency = ''
    email = payment.payer.payer_info.email
    state = payment.state
    created = DateTime.rfc3339(payment.create_time)

    payment.transactions.each do |transaction|
      # summarize the sum of all transactions in this payment
      amount += transaction.amount.total.to_f
      currency = transaction.amount.currency
    end

    amount = "%.2f" % amount

    if email.nil? || email.empty?
      email = 'timmesserschmidt@googlemail.com'
    end

    email = truncate(email, 15)

    created = created.strftime("%m/%d/%Y")

    payments[payment.id] = { amount: "#{amount} #{currency}", email: email, state: state, created: created }
  end

  send_event('payments', { items: payments.values })
end

def truncate(string, length)
  if string.length > length
    string = string.slice(0, length-1)
    string = "#{string}..."
  end
  string
end
