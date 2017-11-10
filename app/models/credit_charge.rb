class CreditCharge < ApplicationRecord
  belongs_to :order

  def charge!(card, amount)
    self.request do
      charge = Payjp::Charge.create(
          card: card,
          amount: amount,
          capture: false,
          currency: 'jpy'
      )
      self.charge_id = charge.id
    end
  end

  def capture!
    self.request do
      Payjp::Charge.retrieve(self.charge_id).capture
    end
  end

  def refund!
    self.request do
      Payjp::Charge.retrieve(self.charge_id).refund
    end
  end

  def request(&block)
    begin
      block.call
    rescue Payjp::CardError => e
      # Since it's a decline, Payjp::CardError will be caught
      body = e.json_body
      err  = body[:error]
      logger.fatal("[PayJp CardError] Status is: #{e.http_status}. Type is: #{err[:type]}. Code is: #{err[:code]}. Param is: #{err[:param]}. Message is: #{err[:message]}")
    rescue Payjp::InvalidRequestError => e
      body = e.json_body
      err  = body[:error]
      logger.fatal("[PayJp InvalidRequestError] Invalid parameters were supplied to Payjp's API. Status is: #{e.http_status}. Type is: #{err[:type]}. Code is: #{err[:code]}. Param is: #{err[:param]}. Message is: #{err[:message]}")
      raise e
    rescue Payjp::AuthenticationError => e
      body = e.json_body
      err  = body[:error]
      logger.fatal("[PayJp AuthenticationError] Authentication with Payjp's API failed. Status is: #{e.http_status}. Type is: #{err[:type]}. Code is: #{err[:code]}. Param is: #{err[:param]}. Message is: #{err[:message]}")
      raise e
    rescue Payjp::APIConnectionError => e
      body = e.json_body
      err  = body[:error]
      logger.fatal("[PayJp APIConnectionError] Network communication with Payjp failed. Status is: #{e.http_status}. Type is: #{err[:type]}. Code is: #{err[:code]}. Param is: #{err[:param]}. Message is: #{err[:message]}")
      raise e
    rescue Payjp::PayjpError => e
      body = e.json_body
      err  = body[:error]
      logger.fatal("[PayJp PayjpError] Display a very generic error to the user, and maybe send yourself an email. Status is: #{e.http_status}. Type is: #{err[:type]}. Code is: #{err[:code]}. Param is: #{err[:param]}. Message is: #{err[:message]}")
      raise e
    rescue => e
      logger.fatal("[PayJp Error] Something else happened, completely unrelated to Payjp. #{e.message}")
      raise e
    end
  end

end
