require 'rails_helper'

RSpec.describe Product, type: :model do

  it "has a valid factory" do
    expect(build(:product)).to be_valid
  end

  it "is invalid without a name" do
    product = build(:product, name: nil)
    product.valid?
    expect(product.errors[:name]).to include("を入力してください")
  end
end
