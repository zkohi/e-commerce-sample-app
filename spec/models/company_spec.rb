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

    context "without a quantity_per_box" do
      let(:company) { build(:company, quantity_per_box: nil) }
      it { expect(company.errors[:quantity_per_box]).to include("を入力してください") }
    end

    context "quantity_per_box is -1" do
      let(:company) { build(:company, quantity_per_box: -1) }
      it { expect(company.errors[:quantity_per_box]).to include("は0以上の値にしてください") }
    end

    context "quantity_per_box is 1000000" do
      let(:company) { build(:company, quantity_per_box: 1000000) }
      it { expect(company.errors[:quantity_per_box]).to include("は999999以下の値にしてください") }
    end
  end
end
