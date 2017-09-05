require 'rails_helper'

RSpec.describe LineItem, type: :model do
  before :each do
    allow(line_item.order).to receive(:ordered?).and_return(ordered)
  end

  let(:ordered) { false }

  context "has a invalid factory" do
    let(:line_item) { build(:line_item) }

    it { expect(line_item).to be_valid }

    context "with a price" do
      let(:line_item) { build(:line_item, :with_price) }
      it { expect(line_item).to be_valid }
    end

  end

  context "has a invalid factory" do
    before :each do
      line_item.valid?
    end

    context "if does not ordered" do
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
        it { expect(line_item.errors[:quantity]).to include("は99以下の値にしてください") }
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
    context "if ordered" do
      let(:ordered) { true }

      context "without a price" do
        let(:line_item) { build(:line_item, price: nil) }
        it { expect(line_item.errors[:price]).to include("を入力してください") }
      end
    end

  end

  describe "ordered?" do
    subject { line_item.ordered? }

    let(:line_item) { build(:line_item) }

    context "if does not ordered" do
      it { is_expected.to be_falsy }
    end

    context "if ordered" do
      let(:ordered) { true }

      it { is_expected.to be_truthy }
    end

  end
end
