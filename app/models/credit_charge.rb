class CreditCharge < ApplicationRecord
  belongs_to :order

  validates :charge_id, presence: true

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
      logger.fatal("[PayJp CardError] #{self.payjp_error_message(e)}")
      raise e
    rescue Payjp::InvalidRequestError => e
      logger.fatal("[PayJp InvalidRequestError] Invalid parameters were supplied to Payjp's API. #{self.payjp_error_message(e)}")
      raise e
    rescue Payjp::AuthenticationError => e
      logger.fatal("[PayJp AuthenticationError] Authentication with Payjp's API failed. #{self.payjp_error_message(e)}")
      raise e
    rescue Payjp::APIConnectionError => e
      logger.fatal("[PayJp APIConnectionError] Network communication with Payjp failed. #{self.payjp_error_message(e)}")
      raise e
    rescue Payjp::PayjpError => e
      logger.fatal("[PayJp PayjpError] Display a very generic error to the user, and maybe send yourself an email. #{self.payjp_error_message(e)}")
      raise e
    rescue => e
      logger.fatal("[PayJp Error] Something else happened, completely unrelated to Payjp. #{e.message}")
      raise e
    end
  end

  def payjp_error_message(e)
    body = e.json_body
    err = body[:error]
    "Status is: #{e.http_status}. Type is: #{err[:type]}. Code is: #{err[:code]}. Param is: #{err[:param]}. Message is: #{err[:message]}"
  end
end
