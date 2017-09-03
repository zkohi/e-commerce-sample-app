require 'rails_helper'

RSpec.describe LineItem, type: :model do

  before :each do
    line_item.order
  end

  context "has a invalid factory" do
    it { expect(build(:line_item)).to be_valid }

    context "with a price" do
      it { expect(build(:line_item, :with_price)).to be_valid }
    end

  end

  context "has a invalid factory" do
    before :each do
      line_item.valid?
    end

    context "without a order_id" do
      let(:line_item) { build(:line_item, order_id: nil) }
      it { expect(line_item.errors[:name]).to include("を入力してください") }
    end

    context "without a product_id" do
      let(:line_item) { build(:line_item, product_id: nil) }
      it { expect(line_item.errors[:product_id]).to include("を入力してください") }
    end

    context "without a quantity" do
      let(:line_item) { build(:line_item, quantity: nil) }
      it { expect(line_item.errors[:quantity]).to include("を入力してください") }
    end

    context "quantity is zero" do
      let(:line_item) { build(:line_item, quantity: 0) }
      it { expect(line_item.errors[:quantity]).to include("は1以上の値にしてください") }
    end

    context "quantity is 100" do
      let(:line_item) { build(:line_item, quantity: 100) }
      it { expect(line_item.errors[:quantity]).to include("は100以下の値にしてください") }
    end

    context "price is zero" do
      let(:line_item) { build(:line_item, price: 0) }
      it { expect(line_item.errors[:price]).to include("は1以上の値にしてください") }
    end

    context "price is 1000000" do
      let(:line_item) { build(:line_item, price: 1000000) }
      it { expect(line_item.errors[:price]).to include("は999999以下の値にしてください") }
    end

  end
end
