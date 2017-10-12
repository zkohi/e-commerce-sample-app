require 'rails_helper'

RSpec.describe UserPoint, type: :model do
  context "has a valid factory" do
    it { expect(build(:user_point)).to be_valid }
  end

  context "has a invalid factory" do
    before :each do
      user_point.valid?
    end

    context "without a state" do
      let(:user_point) { build(:user_point, status: nil) }
      it { expect(user_point.errors[:status]).to include("は一覧にありません") }
    end
    context "without a point" do
      let(:user_point) { build(:user_point, point: nil) }
      it { expect(user_point.errors[:point]).to include("を入力してください") }
    end

    context "point is -1000000" do
      let(:user_point) { build(:user_point, point: -1000000) }
      it { expect(user_point.errors[:point]).to include("は-999999以上の値にしてください") }
    end

    context "point is 1000000" do
      let(:user_point) { build(:user_point, point: 1000000) }
      it { expect(user_point.errors[:point]).to include("は999999以下の値にしてください") }
    end
  end
end
