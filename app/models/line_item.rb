class LineItem < ApplicationRecord
  belongs_to :order
  belongs_to :product

  def set_price
    self.price = self.product.price
  end

end
