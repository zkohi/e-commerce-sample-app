require 'rails_helper'

RSpec.describe Diary, type: :model do
  context "has a valid factory" do
    it { expect(build(:diary)).to be_valid }

    context "with a img_filename" do
      it { expect(build(:diary, :with_img_filename)).to be_valid }
    end

  end

  context "has a invalid factory" do
    before :each do
      diary.valid?
    end

    context "with a invalid img_filename extension" do
      let(:diary) { build(:diary, :with_invalid_img_filename_extension) }
      it { expect(diary.errors[:img_filename]).to include("指定された拡張子[\"txt\"]のファイルは許可されていません。許可されている拡張子は[jpg, jpeg, gif, png]です。") }
    end

    context "without a content" do
      let(:diary) { build(:diary, content: nil) }
      it { expect(diary.errors[:content]).to include("を入力してください") }
    end

    context "content length is too long" do
      let(:diary) { build(:diary, content: 'a' * 501) }
      it { expect(diary.errors[:content]).to include("は500文字以内で入力してください") }
    end
  end
end
