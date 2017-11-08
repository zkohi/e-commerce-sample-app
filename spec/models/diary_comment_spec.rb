require 'rails_helper'

RSpec.describe DiaryComment, type: :model do
  context "has a valid factory" do
    it { expect(build(:diary_comment)).to be_valid }
  end

  context "has a invalid factory" do
    before :each do
      diary_comment.valid?
    end

    context "without a content" do
      let(:diary_comment) { build(:diary_comment, content: nil) }
      it { expect(diary_comment.errors[:content]).to include("を入力してください") }
    end

    context "content length is too long" do
      let(:diary_comment) { build(:diary_comment, content: 'a' * 501) }
      it { expect(diary_comment.errors[:content]).to include("は500文字以内で入力してください") }
    end
  end
end
