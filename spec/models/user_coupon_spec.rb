require 'rails_helper'

RSpec.describe UserCoupon, type: :model do
  context "has a valid factory" do
    it { expect(build(:user_coupon)).to be_valid }
  end
end
