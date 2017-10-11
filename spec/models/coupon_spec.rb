require 'rails_helper'

RSpec.describe Coupon, type: :model do
  context "has a valid factory" do
    it { expect(build(:coupon)).to be_valid }
  end

  context "has a invalid factory" do
    before :each do
      coupon.valid?
    end

    context "without a title" do
      let(:coupon) { build(:coupon, title: nil) }
      it { expect(coupon.errors[:title]).to include("を入力してください") }
    end

    context "title length is too long" do
      let(:coupon) { build(:coupon, title: 'a' * 51) }
      it { expect(coupon.errors[:title]).to include("は50文字以内で入力してください") }
    end

    context "without a code" do
      let(:coupon) { build(:coupon, code: nil) }
      it { expect(coupon.errors[:code]).to include("を入力してください") }
    end

    context "code is not match format" do
      let(:coupon) { build(:coupon, code: '12345678901234') }
      it { expect(coupon.errors[:code]).to include("は不正な値です") }
    end

    context "code is not match format" do
      let(:coupon) { build(:coupon, code: '1234 5678-90aZ') }
      it { expect(coupon.errors[:code]).to include("は不正な値です") }
    end

    context "code is not match format" do
      let(:coupon) { build(:coupon, code: '134-5678-90aZ') }
      it { expect(coupon.errors[:code]).to include("は不正な値です") }
    end

    context "code is not match format" do
      let(:coupon) { build(:coupon, code: '1234-5678-90aZ1') }
      it { expect(coupon.errors[:code]).to include("は不正な値です") }
    end

    context "without a point" do
      let(:coupon) { build(:coupon, point: nil) }
      it { expect(coupon.errors[:point]).to include("を入力してください") }
    end

    context "point is zero" do
      let(:coupon) { build(:coupon, point: 0) }
      it { expect(coupon.errors[:point]).to include("は1以上の値にしてください") }
    end

    context "point is 1000000" do
      let(:coupon) { build(:coupon, point: 1000000) }
      it { expect(coupon.errors[:point]).to include("は999999以下の値にしてください") }
    end
  end
end
