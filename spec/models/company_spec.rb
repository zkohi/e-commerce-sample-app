require 'rails_helper'

RSpec.describe Company, type: :model do
  context "has a valid factory" do
    it { expect(build(:company)).to be_valid }
  end

  context "has a invalid factory" do
    before :each do
      company.valid?
    end

    context "without a name" do
      let(:company) { build(:company, name: nil) }
      it { expect(company.errors[:name]).to include("を入力してください") }
    end

    context "name length is too long" do
      let(:company) { build(:company, name: 'a' * 51) }
      it { expect(company.errors[:name]).to include("は50文字以内で入力してください") }
    end
  end
end
