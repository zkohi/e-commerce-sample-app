require 'rails_helper'

RSpec.describe Order, type: :model do

  context "has a valid factory" do
    before :all do
      Timecop.freeze(Time.local(2017, 9, 4, 10, 5, 0))
    end

    after :all do
      Timecop.return
    end

    it { expect(build(:order)).to be_valid }
    it { expect(build(:order, :ordered)).to be_valid }
  end

  context "has a invalid factory" do

    before :each do
      order.valid?
    end

    context "without a user_id" do
      let(:order) { build(:order, user_id: nil) }
      it { expect(order.errors[:user_id]).to include("を入力してください") }
    end

    context "without a item_count" do
      let(:order) { build(:order, item_count: nil) }
      it { expect(order.errors[:item_count]).to include("を入力してください") }
    end

    context "item_total is less than zero" do
      let(:order) { build(:order, item_total: -1) }
      it { expect(order.errors[:item_total]).to include("は0以上の値にしてください") }
    end

    context "without a shipment_total" do
      let(:order) { build(:order, shipment_total: nil) }
      it { expect(order.errors[:shipment_total]).to include("を入力してください") }
    end

    context "shipment_total is less than zero" do
      let(:order) { build(:order, shipment_total: -1) }
      it { expect(order.errors[:shipment_total]).to include("は0以上の値にしてください") }
    end

    context "without a payment_total" do
      let(:order) { build(:order, payment_total: nil) }
      it { expect(order.errors[:payment_total]).to include("を入力してください") }
    end

    context "payment_total is less than zero" do
      let(:order) { build(:order, payment_total: -1) }
      it { expect(order.errors[:payment_total]).to include("は0以上の値にしてください") }
    end

    context "without a adjustment_total" do
      let(:order) { build(:order, adjustment_total: nil) }
      it { expect(order.errors[:adjustment_total]).to include("を入力してください") }
    end

    context "adjustment_total is less than zero" do
      let(:order) { build(:order, adjustment_total: -1) }
      it { expect(order.errors[:adjustment_total]).to include("は0以上の値にしてください") }
    end

    context "without a tax_total" do
      let(:order) { build(:order, tax_total: nil) }
      it { expect(order.errors[:tax_total]).to include("を入力してください") }
    end

    context "tax_total is less than zero" do
      let(:order) { build(:order, tax_total: -1) }
      it { expect(order.errors[:tax_total]).to include("は0以上の値にしてください") }
    end

    context "without a total" do
      let(:order) { build(:order, total: nil) }
      it { expect(order.errors[:total]).to include("を入力してください") }
    end

    context "item_total is less than zero" do
      let(:order) { build(:order, item_total: -1) }
      it { expect(order.errors[:item_total]).to include("は0以上の値にしてください") }
    end

    context "without a item_total" do
      let(:order) { build(:order, item_total: nil) }
      it { expect(order.errors[:item_total]).to include("を入力してください") }
    end

    context "item_total is less than zero" do
      let(:order) { build(:order, item_total: -1) }
      it { expect(order.errors[:item_total]).to include("は0以上の値にしてください") }
    end

    context "state is ordered" do
      before :all do
        Timecop.freeze(Time.local(2017, 9, 4, 10, 5, 0))
      end

      after :all do
        Timecop.return
      end

      context "without a shipping_date" do
        let(:order) { build(:order, :ordered, shipping_date: nil) }
        it { expect(order.errors[:shipping_date]).to include("の日時を正しく入力してください") }
      end

      context "without a shipping_time_range_string" do
        let(:order) { build(:order, :ordered, shipping_time_range_string: nil) }
        it { expect(order.errors[:shipping_time_range_string]).to include("を入力してください") }
      end

      context "with a invalid shipping_time_range_string" do
        let(:order) { build(:order, :ordered, shipping_time_range_string: "foo") }
        it { expect(order.errors[:shipping_time_range_string]).to include("は一覧にありません") }
      end

      context "without a user_name" do
        let(:order) { build(:order, :ordered, user_name: nil) }
        it { expect(order.errors[:user_name]).to include("を入力してください") }
      end

      context "user_name length is too long" do
        let(:order) { build(:order, :ordered, user_name: "a" * 31) }
        it { expect(order.errors[:user_name]).to include("は30文字以内で入力してください") }
      end

      context "without a user_zipcode" do
        let(:order) { build(:order, :ordered, user_zipcode: nil) }
        it { expect(order.errors[:user_zipcode]).to include("を入力してください") }
      end

      context "user_zipcode length is invalid" do
        let(:order) { build(:order, :ordered, user_zipcode: 123456) }
        it { expect(order.errors[:user_zipcode]).to include("は7文字で入力してください") }
      end

      context "without a user_address" do
        let(:order) { build(:order, :ordered, user_address: nil) }
        it { expect(order.errors[:user_address]).to include("を入力してください") }
      end

      context "user_address length is too long" do
        let(:order) { build(:order, :ordered, user_address: "a" * 101) }
        it { expect(order.errors[:user_address]).to include("は100文字以内で入力してください") }
      end
    end
  end

  describe "shipping_date" do
    before :each do
      Timecop.freeze(now)
      order.valid?
    end

    after :each do
      Timecop.return
    end

    shared_examples "validate shipping_date" do |minDate, maxDate|
      let(:order) { build(:order, :ordered, shipping_date: shipping_date) }

      context "shipping_date is on after" do
        let(:shipping_date) { Date.today + minDate.days }
        it { expect(build(:order, :ordered, shipping_date: shipping_date)).to be_valid }
      end

      context "shipping_date is on before" do
        let(:shipping_date) { Date.today + maxDate.days }
        it { expect(build(:order, :ordered, shipping_date: shipping_date)).to be_valid }
      end

      context "shipping_date is after" do
        let(:shipping_date) { Date.today + minDate.days - 1.day }
        it { expect(order.errors[:shipping_date]).to include("は3営業日（営業日: 月-金）から14営業日までを指定してください") }
      end

      context "shipping_date is before" do
        let(:shipping_date) { Date.today + maxDate.days + 1.day }
        it { expect(order.errors[:shipping_date]).to include("は3営業日（営業日: 月-金）から14営業日までを指定してください") }
      end
    end

    context "today is monday" do
      let(:now) { Time.local(2017, 9, 4, 10, 5, 0) }

      it_should_behave_like "validate shipping_date", 2, 17
    end

    context "today is tuesday" do
      let(:now) { Time.local(2017, 9, 5, 10, 5, 0) }

      it_should_behave_like "validate shipping_date", 2, 17
    end

    context "today is wednesday" do
      let(:now) { Time.local(2017, 9, 6, 10, 5, 0) }

      it_should_behave_like "validate shipping_date", 2, 19
    end

    context "today is thursday" do
      let(:now) { Time.local(2017, 9, 7, 10, 5, 0) }

      it_should_behave_like "validate shipping_date", 4, 19
    end

    context "today is friday" do
      let(:now) { Time.local(2017, 9, 8, 10, 5, 0) }

      it_should_behave_like "validate shipping_date", 4, 19
    end

    context "today is saturday" do
      let(:now) { Time.local(2017, 9, 9, 10, 5, 0) }

      it_should_behave_like "validate shipping_date", 4, 19
    end

    context "today is sunday" do
      let(:now) { Time.local(2017, 9, 10, 10, 5, 0) }

      it_should_behave_like "validate shipping_date", 3, 18
    end
  end
end
