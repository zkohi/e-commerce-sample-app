require 'rails_helper'

RSpec.describe User, type: :model do
  context "has a invalid factory" do
    it { expect(build(:user)).to be_valid }

    context "with a profile" do
      it { expect(build(:user, :with_profile)).to be_valid }
    end

  end

  context "has a invalid factory" do
    before :each do
      user.valid?
    end

    context "name length is too long" do
      let(:user) { build(:user, name: "a" * 31) }
      it { expect(user.errors[:name]).to include("は30文字以内で入力してください") }
    end

    context "zipcode length is invalid" do
      let(:user) { build(:user, zipcode: 123456) }
      it { expect(user.errors[:zipcode]).to include("は7文字で入力してください") }
    end

    context "address length is too long" do
      let(:user) { build(:user, address: "a" * 101) }
      it { expect(user.errors[:address]).to include("は100文字以内で入力してください") }
    end
  end
end
