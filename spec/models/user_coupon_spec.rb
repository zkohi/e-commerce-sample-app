require 'rails_helper'

RSpec.describe UserCoupon, type: :model do
  context "has a valid factory" do
    it { expect(build(:user_coupon)).to be_valid }
  end

  context "has a invalid factory" do
    before :each do
      user_coupon.valid?
    end

    context "without a point" do
      let(:user_coupon) { build(:user_coupon, point: nil) }
      it { expect(user_coupon.errors[:point]).to include("を入力してください") }
    end

    context "point is zero" do
      let(:user_coupon) { build(:user_coupon, point: 0) }
      it { expect(user_coupon.errors[:point]).to include("は1以上の値にしてください") }
    end

    context "point is 1000000" do
      let(:user_coupon) { build(:user_coupon, point: 1000000) }
      it { expect(user_coupon.errors[:point]).to include("は999999以下の値にしてください") }
    end
  end
end
