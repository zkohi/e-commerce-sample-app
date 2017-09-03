require 'rails_helper'

RSpec.describe Product, type: :model do

  context "has a invalid factory" do
    it { expect(build(:product)).to be_valid }

    context "with a img_filename" do
      it { expect(build(:product, :with_img_filename)).to be_valid }
    end

  end

  context "has a invalid factory" do
    before :each do
      product.valid?
    end

    context "without a name" do
      let(:product) { build(:product, name: nil) }
      it { expect(product.errors[:name]).to include("を入力してください") }
    end

    context "name length is too long" do
      let(:product) { build(:product, name: "a" * 31) }
      it { expect(product.errors[:name]).to include("は30文字以内で入力してください") }
    end

    context "with a invalid img_filename extension" do
      let(:product) { build(:product, :with_invalid_img_filename_extension) }
      it { expect(product.errors[:img_filename]).to include("指定された拡張子[\"txt\"]のファイルは許可されていません。許可されている拡張子は[jpg, jpeg, gif, png]です。") }
    end

    context "without a price" do
      let(:product) { build(:product, price: nil) }
      it { expect(product.errors[:price]).to include("を入力してください") }
    end

    context "price is zero" do
      let(:product) { build(:product, price: 0) }
      it { expect(product.errors[:price]).to include("は1以上の値にしてください") }
    end

    context "price is 1000000" do
      let(:product) { build(:product, price: 1000000) }
      it { expect(product.errors[:price]).to include("は999999以下の値にしてください") }
    end

    context "without a description" do
      let(:product) { build(:product, description: nil) }
      it { expect(product.errors[:description]).to include("を入力してください") }
    end

    context "description length is too long" do
      let(:product) { build(:product, description: 'a' * 501) }
      it { expect(product.errors[:description]).to include("は500文字以内で入力してください") }
    end

    context "without a flg_non_display" do
      let(:product) { build(:product, flg_non_display: nil) }
      it { expect(product.errors[:flg_non_display]).to include("は一覧にありません") }
    end

    context "without a sort_order" do
      let(:product) { build(:product, sort_order: nil) }
      it { expect(product.errors[:sort_order]).to include("を入力してください") }
    end

    context "sort_order is zero" do
      let(:product) { build(:product, sort_order: 0) }
      it { expect(product.errors[:sort_order]).to include("は1以上の値にしてください") }
    end

    context "sort_order is 1000000" do
      let(:product) { build(:product, price: 1000000) }
      it { expect(product.errors[:price]).to include("は999999以下の値にしてください") }
    end

  end
end
