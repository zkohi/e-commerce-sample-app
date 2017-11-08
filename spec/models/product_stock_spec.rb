require 'rails_helper'

RSpec.describe ProductStock, type: :model do
  context "has a valid factory" do
    it { expect(build(:product_stock)).to be_valid }
  end

  context "has a invalid factory" do
    before :each do
      product_stock.valid?
    end

    context "without a stock" do
      let(:product_stock) { build(:product_stock, stock: nil) }
      it { expect(product_stock.errors[:stock]).to include("を入力してください") }
    end

    context "stock is zero" do
      let(:product_stock) { build(:product_stock, stock: -1) }
      it { expect(product_stock.errors[:stock]).to include("は0以上の値にしてください") }
    end

    context "stock is 1000000" do
      let(:product_stock) { build(:product_stock, stock: 1000000) }
      it { expect(product_stock.errors[:stock]).to include("は999999以下の値にしてください") }
    end
  end
end
