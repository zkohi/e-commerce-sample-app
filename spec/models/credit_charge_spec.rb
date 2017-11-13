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

  describe "charge!" do
    subject { order.credit_charge.charge!(card, amount) }

    before :each do
      allow(Payjp::Charge).to receive(:create).and_return(charge)
    end

    let(:order) { build(:order, :ordered, :with_credit_charge) }
    let(:card) { 'card' }
    let(:amount) { 1234 }
    let(:params) {
      {
        card: card,
        amount: amount,
        capture: false,
        currency: 'jpy'
      }
    }
    let(:charge) { double('charge', id: charge_id) }
    let(:charge_id) { 'charge_id' }

    it "sets charge_id" do
      should
      expect(order.credit_charge.charge_id).to eq charge_id
    end

    it "calls Payjp::Charge.create with params" do
      should
      expect(Payjp::Charge).to have_received(:create).with(params)
    end
  end

  describe "capture!" do
    subject { order.credit_charge.capture! }

    before :each do
      allow(Payjp::Charge).to receive(:retrieve).and_return(charge)
      allow(charge).to receive(:capture)
    end

    let(:order) { build(:order, :ordered, :with_credit_charge) }
    let(:charge) { double('charge') }
    let(:charge_id) { 'charge_id_1234567890' }

    it "calls Payjp::Charge.retrieve(chage_id).capture" do
      should
      expect(Payjp::Charge).to have_received(:retrieve).with(charge_id)
      expect(charge).to have_received(:capture)
    end
  end

  describe "refund!" do
    subject { order.credit_charge.refund! }

    before :each do
      allow(Payjp::Charge).to receive(:retrieve).and_return(charge)
      allow(charge).to receive(:refund)
    end

    let(:order) { build(:order, :ordered, :with_credit_charge) }
    let(:charge) { double('charge') }
    let(:charge_id) { 'charge_id_1234567890' }

    it "calls Payjp::Charge.retrieve(chage_id).refund" do
      should
      expect(Payjp::Charge).to have_received(:retrieve).with(charge_id)
      expect(charge).to have_received(:refund)
    end
  end

  describe "request!" do
    subject { order.credit_charge.request(&block) }

    let(:block) { Proc.new { p 'foo' } }
    let(:order) { build(:order, :ordered, :with_credit_charge) }

    context "if don't raise Error" do
      before :each do
        allow(block).to receive(:call)
      end

      it "calls block.call" do
        should
        expect(block).to have_received(:call)
      end
    end

    context "if raise Error" do
      before :each do
        allow(Rails.logger).to receive(:fatal)
        allow(block).to receive(:call).and_raise(e)
        e.instance_variable_set(:@json_body, json_body)
      end

      let(:json_body) {
        {
          error: {
            type: type,
            param: param,
            code: code,
            message: message
          }
        }
      }
      let(:type) { 'Error Type' } 
      let(:param) { 'Error Param' } 
      let(:code) { 'Error Code' } 
      let(:message) { 'Error Message' } 

      context "if raise Payjp::CardError" do
        let(:e) { Payjp::CardError.new(message, param, code) }

        it do
          expect { subject }.to raise_error(e)
          expect(Rails.logger).to have_received(:fatal)
        end
      end

      context "if raise Payjp::InvalidRequestError" do
        let(:e) { Payjp::InvalidRequestError.new(message, param, code) }

        it do
          expect { subject }.to raise_error(e)
          expect(Rails.logger).to have_received(:fatal)
        end
      end

      context "if raise Payjp::AuthenticationError" do
        let(:e) { Payjp::AuthenticationError.new(message, param, code) }

        it do
          expect { subject }.to raise_error(e)
          expect(Rails.logger).to have_received(:fatal)
        end
      end

      context "if raise Payjp::APIConnectionError" do
        let(:e) { Payjp::APIConnectionError.new(message, param, code) }

        it do
          expect { subject }.to raise_error(e)
          expect(Rails.logger).to have_received(:fatal)
        end
      end

      context "if raise Payjp::PayjpError" do
        let(:e) { Payjp::PayjpError.new(message, param, code) }

        it do
          expect { subject }.to raise_error(e)
          expect(Rails.logger).to have_received(:fatal)
        end
      end

      context "if raise Error" do
        let(:e) { StandardError.new(message) }

        it do
          expect { subject }.to raise_error(e)
          expect(Rails.logger).to have_received(:fatal)
        end
      end
    end
  end
end
