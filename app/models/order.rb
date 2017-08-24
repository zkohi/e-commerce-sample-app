class Order < ApplicationRecord
  has_many :line_items
  belongs_to :user

  before_save :calculate_total

  accepts_nested_attributes_for :line_items

  def set_line_item_price
    #self.line_items(&:set_price)
    self.line_items.include(:product).each { |i| i.set_price }
  end

  def calculate_total
    line_item = self.line_items.first
    set_item_count(line_item)
    set_shipment_total
    set_item_total(line_item)
    set_payment_total
    set_adjustment_total
    set_tax_total
    self.total = self.adjustment_total + self.tax_total
  end

  private

  def set_item_count(line_item)
    self.item_count += line_item.quantity
  end

  def set_shipment_total
    self.shipment_total = (self.item_count / 5).ceil * 600
  end

  def set_item_total(line_item)
    self.item_total += line_item.price * line_item.quantity
  end

  def set_payment_total
    self.payment_total = case self.item_total
                         when 0 ... 10000
                           300
                         when 10000 ... 30000
                           400
                         when 30000 ... 100000
                           600
                         else
                           1000
                         end
  end

  def set_adjustment_total
    self.adjustment_total = self.shipment_total + self.item_total + self.payment_total
  end

  def set_tax_total
    self.tax_total = (self.adjustment_total * 0.08).floor
  end

end
