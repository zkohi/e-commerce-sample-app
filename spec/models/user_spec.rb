require 'rails_helper'

RSpec.describe User, type: :model do

  context "has a valid factory" do
    it { expect(build(:user)).to be_valid }

    context "with a profile" do
      it { expect(build(:user, :with_profile, :with_img_filename)).to be_valid }
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

    context "nickname length is too long" do
      let(:user) { build(:user, nickname: "a" * 31) }
      it { expect(user.errors[:nickname]).to include("は30文字以内で入力してください") }
    end

    context "with a invalid img_filename extension" do
      let(:user) { build(:user, :with_invalid_img_filename_extension) }
      it { expect(user.errors[:img_filename]).to include("指定された拡張子[\"txt\"]のファイルは許可されていません。許可されている拡張子は[jpg, jpeg, gif, png]です。") }
    end
  end

  describe "set_diary_evaluation_ids" do
    subject { user.set_diary_evaluation_ids(diaries) }

    let(:diary_evaluation) { create(:diary_evaluation) }
    let(:user) { diary_evaluation.user }
    let(:diary) { diary_evaluation.diary }
    let(:diaries) { [diary] }
    let(:expected) {
      {
        diary_evaluation.diary.id => diary_evaluation.id
      }
    }

    it do
      should
      expect(user.instance_variable_get(:@diary_evaluation_ids)).to eq expected
    end

    after :each do
      user.destroy
    end
  end

  describe "diary_evaluated?" do
    subject { user.diary_evaluated?(diary) }

    before :each do
      user.set_diary_evaluation_ids(diaries)
    end

    let(:diary_evaluation) { create(:diary_evaluation) }
    let(:diary) { diary_evaluation.diary }
    let(:diaries) { [diary] }

    context "a diary is evaluated by user" do
      let(:user) { diary_evaluation.user }
      it { is_expected.to be_truthy }
    end

    context "a diary is not evaluated by user" do
      let(:user) { create(:user) }
      it { is_expected.to be_falsey }
    end

    after :each do
      user.destroy
      diary.destroy
    end
  end

  describe "diary_evaluation_id" do
    subject { user.diary_evaluation_id(diary) }

    before :each do
      user.set_diary_evaluation_ids(diaries)
    end

    let(:diary_evaluation) { create(:diary_evaluation) }
    let(:user) { diary_evaluation.user }
    let(:diary) { diary_evaluation.diary }
    let(:diaries) { [diary] }

    it { is_expected.to eq diary_evaluation.id }

    after :each do
      user.destroy
    end
  end
end
