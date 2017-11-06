require 'rails_helper'

RSpec.describe DiariesHelper, type: :helper do
  describe "diary_created_at_ago" do
    describe "change diary created_at to time ago" do
      before :all do
        Timecop.freeze(Time.local(2017, 9, 4, 10, 5, 0))
      end

      after :all do
        Timecop.return
      end

      subject { helper.diary_created_at_ago(diary) }

      let(:diary) { build(:diary, created_at: created_at) }
      let(:now) { Time.now }
      let(:created_at) { now - sub_seconds }

      context "if 1 second ago" do
        let(:sub_seconds) { 1 }
        it { is_expected.to eq "1秒前" }
      end

      context "if 59 seconds ago" do
        let(:sub_seconds) { 59 }
        it { is_expected.to eq "59秒前" }
      end

      context "if 60 seconds ago" do
        let(:sub_seconds) { 60 }
        it { is_expected.to eq "1分前" }
      end

      context "if 2669 seconds ago" do
        let(:sub_seconds) { 2669 }
        it { is_expected.to eq "44分前" }
      end

      context "if 2670 seconds ago" do
        let(:sub_seconds) { 2670 }
        it { is_expected.to eq "約1時間前" }
      end

      context "if 86369 seconds ago" do
        let(:sub_seconds) { 86369 }
        it { is_expected.to eq "約24時間前" }
      end

      context "if 86370 seconds ago" do
        let(:sub_seconds) { 86370 }
        it { is_expected.to eq "1日前" }
      end

      context "if 151169 seconds ago" do
        let(:sub_seconds) { 151169 }
        it { is_expected.to eq "1日前" }
      end

      context "if 151170 seconds ago" do
        let(:sub_seconds) { 151170 }
        it { is_expected.to eq "2日前" }
      end

      context "if 2591969 seconds ago" do
        let(:sub_seconds) { 2591969 }
        it { is_expected.to eq "30日前" }
      end

      context "if 2591970 seconds ago" do
        let(:sub_seconds) { 2591970 }
        it { is_expected.to eq "約1ヶ月前" }
      end
    end
  end
end
