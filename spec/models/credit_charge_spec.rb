require 'rails_helper'

RSpec.describe CreditCharge, type: :model do
  context "has a valid factory" do
    it { expect(build(:credit_charge)).to be_valid }
  end

  context "has a invalid factory" do
    before :each do
      credit_charge.valid?
    end

    context "without a charge_id" do
      let(:credit_charge) { build(:credit_charge, charge_id: nil) }
      it { expect(credit_charge.errors[:charge_id]).to include("を入力してください") }
    end
  end
end
