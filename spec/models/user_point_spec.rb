require 'rails_helper'

RSpec.describe UserPoint, type: :model do
  context "has a valid factory" do
    it { expect(build(:user_point, :user_point_used)).to be_valid }
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

  describe "update_total" do
    subject { user_point.send(:update_total) }

    let(:user_point) { build(:user_point, :user_point_used, point: 100) }

    context "if exists status is total" do
      before :each do
        user_point_total.save
      end

      let(:user_point_total) { create(:user_point, :user_point_total, user: user_point.user, point: 1000) }

      it do
        should
        expect(user_point_total.reload.point).to eq 1100
      end

      it do
        should
        expect(user_point_total.status).to eq 'total'
      end
    end

    context "if not exists status is total" do
      let(:user_point_total) { described_class.find_by(user_id: user_point.user.id, status: :total) }

      it do
        should
        expect(user_point_total.point).to eq 100
      end

      it do
        should
        expect(user_point_total.status).to eq 'total'
      end
    end

    after :each do
      user_point_total.destroy
    end
  end
end
