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

    context "point_total is zero" do
      let(:order) { build(:order, point_total: 0) }
      it { expect(order.errors[:point_total]).to include("は1以上の値にしてください") }
    end

    context "point_total greater than 999999" do
      let(:order) { build(:order, point_total: 1000000) }
      it { expect(order.errors[:point_total]).to include("は999999以下の値にしてください") }
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

      context "without a shipping_time_range" do
        context "without a shipping_time_range_string" do
          let(:order) { build(:order, :ordered, shipping_time_range: nil, shipping_time_range_string: nil) }
          it { expect(order.errors[:shipping_time_range_string]).to include("を入力してください") }
        end

        context "with a invalid shipping_time_range_string" do
          let(:order) { build(:order, :ordered, shipping_time_range: nil, shipping_time_range_string: "foo") }
          it { expect(order.errors[:shipping_time_range_string]).to include("は一覧にありません") }
        end
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

      context "without a payment_type" do
        let(:order) { build(:order, :ordered, payment_type: nil) }
        it { expect(order.errors[:payment_type]).to include("を入力してください") }
      end
    end
  end

  describe "shipping_date" do

    let(:now) { Time.local(2017, 9, 4, 10, 5, 0) }
    let(:order) { build(:order, :ordered, shipping_date: shipping_date) }

    before :each do
      Timecop.freeze(now)
      order.valid?
    end

    after :each do
      Timecop.return
    end

    context "selected shipping_date" do
      context "is monday" do
        let(:shipping_date) { Time.local(2017, 9, 11, 10, 5, 0) }
        it { expect(build(:order, :ordered, shipping_date: shipping_date)).to be_valid }
      end

      context "is tuesday" do
        let(:shipping_date) { Time.local(2017, 9, 12, 10, 5, 0) }
        it { expect(build(:order, :ordered, shipping_date: shipping_date)).to be_valid }
      end

      context "is wednesday" do
        let(:shipping_date) { Time.local(2017, 9, 13, 10, 5, 0) }
        it { expect(build(:order, :ordered, shipping_date: shipping_date)).to be_valid }
      end

      context "is thursday" do
        let(:shipping_date) { Time.local(2017, 9, 14, 10, 5, 0) }
        it { expect(build(:order, :ordered, shipping_date: shipping_date)).to be_valid }
      end

      context "is friday" do
        let(:shipping_date) { Time.local(2017, 9, 15, 10, 5, 0) }
        it { expect(build(:order, :ordered, shipping_date: shipping_date)).to be_valid }
      end

      context "is saturday" do
        let(:shipping_date) { Time.local(2017, 9, 16, 10, 5, 0) }
        it { expect(order.errors[:shipping_date]).to include("は3営業日（営業日: 月-金）から14営業日までを指定してください") }
      end

      context "is sunday" do
        let(:shipping_date) { Time.local(2017, 9, 17, 10, 5, 0) }
        it { expect(order.errors[:shipping_date]).to include("は3営業日（営業日: 月-金）から14営業日までを指定してください") }
      end
    end

    context "order date(today)" do
      shared_examples "validate shipping_date" do |minDate, maxDate|

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

      context "is monday" do
        let(:now) { Time.local(2017, 9, 4, 10, 5, 0) }

        it_should_behave_like "validate shipping_date", 2, 17
      end

      context "is tuesday" do
        let(:now) { Time.local(2017, 9, 5, 10, 5, 0) }

        it_should_behave_like "validate shipping_date", 2, 17
      end

      context "is wednesday" do
        let(:now) { Time.local(2017, 9, 6, 10, 5, 0) }

        it_should_behave_like "validate shipping_date", 2, 19
      end

      context "is thursday" do
        let(:now) { Time.local(2017, 9, 7, 10, 5, 0) }

        it_should_behave_like "validate shipping_date", 4, 19
      end

      context "is friday" do
        let(:now) { Time.local(2017, 9, 8, 10, 5, 0) }

        it_should_behave_like "validate shipping_date", 4, 19
      end

      context "is saturday" do
        let(:now) { Time.local(2017, 9, 9, 10, 5, 0) }

        it_should_behave_like "validate shipping_date", 4, 19
      end

      context "is sunday" do
        let(:now) { Time.local(2017, 9, 10, 10, 5, 0) }

        it_should_behave_like "validate shipping_date", 3, 18
      end
    end
  end

  describe "point_total" do
    subject { order.valid? }

    context "if point_total greater than adjustment_total" do
      let(:order) { build(:order, :ordered, point_total: 2601) }

      it do
        should
        expect(order.errors[:point_total]).to include("は1以上2600以下の値にしてください")
      end
    end

    context "if point is not exist" do
      let(:order) { build(:order, :ordered, point_total: 1000) }

      it do
        should
        expect(order.errors[:point_total]).to include("がありません")
      end
    end

    context "if point_total greater than users point total" do
      before :each do
        user_point.save
      end

      let(:user_point) { UserPoint.create(user_id: order.user.id, status: :total, point: 999) }
      let(:order) { build(:order, :ordered, point_total: 1000) }

      it do
        should
        expect(order.errors[:point_total]).to include("は999以下の値にしてください")
      end

      after :each do
        user_point.destroy
      end
    end
  end

  describe "available_shipping_date_range" do
    subject { build(:order).available_shipping_date_range }

    before :each do
      Timecop.freeze(now)
    end

    after :each do
      Timecop.return
    end

    context "today is monday" do
      let(:now) { Time.local(2017, 9, 4, 10, 5, 0) }
      let(:expected) {
        {
          minDate: 2,
          maxDate: 17
        }
      }

      it { is_expected.to eq expected }
    end

    context "today is tuesday" do
      let(:now) { Time.local(2017, 9, 5, 10, 5, 0) }
      let(:expected) {
        {
          minDate: 2,
          maxDate: 17
        }
      }

      it { is_expected.to eq expected }
    end

    context "today is wednesday" do
      let(:now) { Time.local(2017, 9, 6, 10, 5, 0) }
      let(:expected) {
        {
          minDate: 2,
          maxDate: 19
        }
      }

      it { is_expected.to eq expected }
    end

    context "today is thursday" do
      let(:now) { Time.local(2017, 9, 7, 10, 5, 0) }
      let(:expected) {
        {
          minDate: 4,
          maxDate: 19
        }
      }

      it { is_expected.to eq expected }
    end

    context "today is friday" do
      let(:now) { Time.local(2017, 9, 8, 10, 5, 0) }
      let(:expected) {
        {
          minDate: 4,
          maxDate: 19
        }
      }

      it { is_expected.to eq expected }
    end

    context "today is saturday" do
      let(:now) { Time.local(2017, 9, 9, 10, 5, 0) }
      let(:expected) {
        {
          minDate: 4,
          maxDate: 19
        }
      }

      it { is_expected.to eq expected }
    end

    context "today is sunday" do
      let(:now) { Time.local(2017, 9, 10, 10, 5, 0) }
      let(:expected) {
        {
          minDate: 3,
          maxDate: 18
        }
      }

      it { is_expected.to eq expected }
    end
  end

  describe "set_point_total" do
    subject { order.send(:set_point_total) }

    let(:order) { build(:order, :with_point_total) }

    it do
      should
      expect(order.point_total).to eq 1000
    end
  end

  describe "set_item_count" do
    subject { order.send(:set_item_count) }

    let(:order) { create(:order_with_line_items).reload }

    it do
      should
      expect(order.item_count).to eq 20
    end

    after :each do
      order.destroy
    end
  end

  describe "set_item_total" do
    subject { order.send(:set_item_total) }

    let(:order) { create(:order_with_line_items).reload }
    let(:expected) { 20000 }

    it do
      should
      expect(order.item_total).to eq expected
    end

    after :each do
      order.destroy
    end
  end

  describe "set_shipment_total" do
    subject { order.send(:set_shipment_total) }

    let(:company) { build(:company, quantity_per_box: 5) }
    let(:order) { build(:order, company: company, item_count: item_count) }

    context "if item_count is equal company.quantity_per_box" do
      let(:item_count) { 5 }

      it do
        should
        expect(order.shipment_total).to eq 600
      end
    end

    context "if item_count is greater than company.quantity_per_box" do
      let(:item_count) { 6 }

      it do
        should
        expect(order.shipment_total).to eq 1200
      end
    end

    context "if item_count is equal company.quantity_per_box * 2" do
      let(:item_count) { 10 }

      it do
        should
        expect(order.shipment_total).to eq 1200
      end
    end

    context "if item_count is greater than company.quantity_per_box * 2 + 1" do
      let(:item_count) { 11 }

      it do
        should
        expect(order.shipment_total).to eq 1800
      end
    end
  end

  describe "set_payment_total" do
    subject { order.send(:set_payment_total) }

    let(:order) { build(:order, adjustment_total: adjustment_total) }

    context "if adjustment_total is zero" do
      let(:adjustment_total) { 0 }

      it do
        should
        expect(order.payment_total).to eq 0
      end
    end

    context "if adjustment_total is 9999" do
      let(:adjustment_total) { 9999 }

      it do
        should
        expect(order.payment_total).to eq 300
      end
    end

    context "if adjustment_total is 10000" do
      let(:adjustment_total) { 10000 }

      it do
        should
        expect(order.payment_total).to eq 400
      end
    end

    context "if adjustment_total is 29999" do
      let(:adjustment_total) { 29999 }

      it do
        should
        expect(order.payment_total).to eq 400
      end
    end

    context "if adjustment_total is 99999" do
      let(:adjustment_total) { 99999 }

      it do
        should
        expect(order.payment_total).to eq 600
      end
    end

    context "if adjustment_total is 100000" do
      let(:adjustment_total) { 100000 }

      it do
        should
        expect(order.payment_total).to eq 1000
      end
    end
  end

  describe "set_adjustment_total" do
    subject { order.send(:set_adjustment_total) }

    let(:order) { build(:order, item_total: item_total, shipment_total: shipment_total, point_total: point_total) }
    let(:shipment_total) { 600 }
    let(:item_total) { 1000 }

    context "if point_total is present" do
      let(:point_total) { 100 }

      it do
        should
        expect(order.adjustment_total).to eq 1500
      end
    end

    context "if point_total is not present" do
      let(:point_total) { nil }

      it do
        should
        expect(order.adjustment_total).to eq 1600
      end
    end
  end

  describe "set_tax_total" do
    subject { order.send(:set_tax_total) }

    let(:order) { build(:order, adjustment_total: adjustment_total, payment_total: payment_total) }

    context "小数点が発生する場合" do
      let(:adjustment_total) { 10 }
      let(:payment_total) { 20 }

      it "小数点以下は切り捨てられること" do
        should
        expect(order.tax_total).to eq 2
      end
    end

    context "小数点が発生しない場合" do
      let(:adjustment_total) { 1000 }
      let(:payment_total) { 2000 }

      it do
        should
        expect(order.tax_total).to eq 240
      end
    end
  end

  describe "set_total" do
    subject { order.send(:set_total) }

    let(:order) { build(:order, adjustment_total: adjustment_total, payment_total: payment_total, tax_total: tax_total) }
    let(:adjustment_total) { 2000 }
    let(:payment_total) { 1000 }
    let(:tax_total) { 240 }
    let(:expected) { 3240 }

    it do
      should
      expect(order.total).to eq expected
    end
  end

  describe "set_shipping_time_range_string" do
    subject { order.send(:set_shipping_time_range_string) }

    let(:order) { build(:order) }

    it do
      should
      expect(order.shipping_time_range_string).to eq "8時〜12時"
    end
  end

  describe "save_user_point" do
    subject { order.send(:save_user_point) }

    before :each do
      @user_point_total = create(:user_point, :user_point_total, user: order.user, point: order.point_total + 1)
    end

    let(:order) { create(:order, :with_point_total) }
    let(:user_point) { UserPoint.find_by(order_id: order.id, user_id: order.user.id) }

    it do
      should
      expect(user_point.point).to eq -order.point_total
    end

    it do
      should
      expect(user_point.status).to eq "used"
    end

    after :each do
      order.destroy
      @user_point_total.destroy
      user_point.destroy
    end
  end

end
