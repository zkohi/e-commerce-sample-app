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

      context "if 3599 seconds ago" do
        let(:sub_seconds) { 3599 }
        it { is_expected.to eq "59分前" }
      end

      context "if 3600 seconds ago" do
        let(:sub_seconds) { 3600 }
        it { is_expected.to eq "1時間前" }
      end

      context "if 86399 seconds ago" do
        let(:sub_seconds) { 86399 }
        it { is_expected.to eq "23時間前" }
      end

      context "if 86400 seconds ago" do
        let(:sub_seconds) { 86400 }
        it { is_expected.to eq "1日前" }
      end

      context "if 172799 seconds ago" do
        let(:sub_seconds) { 172799 }
        it { is_expected.to eq "1日前" }
      end

      context "if 172800 seconds ago" do
        let(:sub_seconds) { 172800 }
        it { is_expected.to eq "2日前" }
      end
    end
  end
end
