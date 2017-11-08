require 'rails_helper'

RSpec.describe "Diaries", type: :request do
  describe "GET /" do
    it "shows diaries" do
      user = FactoryGirl.create(:user)
      login_as(user, scope: :user)

      get root_path
      expect(response).to render_template(:index)
    end
  end

  describe "GET /diaries/new and GET /diaries/:id/edit and PATCH /diaries/:id and DELETE /diaries/:id" do
    it "creates a Diary and edits a Diary and deletes a Diary and redirects to the Diary's page" do
      user = FactoryGirl.create(:user)
      login_as(user, scope: :user)

      get new_diary_path
      expect(response).to render_template(:new)

      post diaries_path, params: {
        diary: {
          title: "My Diary",
          content: "My Diary content"
        }
      }

      expect(response).to redirect_to(assigns(:diary))
      follow_redirect!

      expect(response).to render_template(:show)
      expect(response.body).to include("新しい日記を作成しました")

      diary = Diary.find(response.request.filtered_parameters["id"])

      get edit_diary_path diary
      expect(response).to render_template(:edit)

      patch diary_path diary, params: {
        diary: {
          title: "My Diary Edit",
          content: "My Diary content Edit"
        }
      }

      expect(response).to redirect_to(diary)
      follow_redirect!

      expect(response).to render_template(:show)
      expect(response.body).to include("日記を更新しました")

      delete diary_path diary

      expect(response).to redirect_to(mypage_path)
      follow_redirect!

      expect(response).to render_template(:show)
      expect(response.body).to include("日記を削除しました")
    end
  end


  describe "GET /diaries/:id/ and POST /diaries/:diary_id/comments and DELETE /diaries/:diary_id/comments/:id and POST /diaries/:diary_id/evaluations and DELETE /diaries/:diary_id/evaluations/:id" do
    it "shows diary and post comment and delete comment and create evaluation and delete evaluation" do
      user = FactoryGirl.create(:user)
      login_as(user, scope: :user)

      diary = FactoryGirl.create(:diary)

      get diary_path diary

      expect(response).to render_template(:show)

      post diary_comments_path diary, params: {
        diary_comment: {
          content: 'Diary Content'
        }
      }

      expect(response).to redirect_to(diary_path(diary))
      follow_redirect!

      expect(response).to render_template(:show)
      expect(response.body).to include("コメントを登録しました")

      post diary_evaluations_path diary, params: {}

      expect(response).to redirect_to(diary_path(diary))
      follow_redirect!

      expect(response).to render_template(:show)
      expect(response.body).to include("評価を登録しました")

      comment = user.diary_comments.find_by(diary_id: diary.id)

      delete diary_comment_path diary, comment

      expect(response).to redirect_to(diary_path(diary))
      follow_redirect!

      expect(response).to render_template(:show)
      expect(response.body).to include("コメントを削除しました")

      evaluation = user.diary_evaluations.find_by(diary_id: diary.id)

      delete diary_evaluation_path diary, evaluation

      expect(response).to redirect_to(diary_path(diary))
      follow_redirect!

      expect(response).to render_template(:show)
      expect(response.body).to include("評価を削除しました")
    end
  end
end
