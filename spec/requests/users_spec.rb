require 'rails_helper'

RSpec.describe "Users", type: :request do

  describe "GET /users/sign_up" do
    it "creates a User and redirects to the Root page and sign_out and sign_in" do
      get new_user_registration_path
      expect(response).to render_template(:new)

      post user_registration_path, params: {
        user: {
          email: "test@gmail.com",
          password: "userpassword",
          password_confirmation: "userpassword"
        }
      }

      expect(response).to redirect_to(root_path)
      follow_redirect!

      expect(response).to render_template(:index)

      get destroy_user_session_path

      expect(response).to redirect_to(new_user_session_path)
      follow_redirect!

      expect(response).to render_template(:new)

      post new_user_session_path, params: {
        user: {
          email: "test@gmail.com",
          password: "userpassword",
        }
      }

      expect(response).to redirect_to(root_path)
      follow_redirect!

      expect(response).to render_template(:index)
    end
  end

  describe "GET /mypage" do
    it "shows Mypage" do
      user = FactoryGirl.create(:user)
      login_as(user, scope: :user)

      get mypage_path
      expect(response).to render_template(:show)
    end
  end

  describe "GET /users/edit" do
    it "updates a User and redirects to the User's page" do
      user = FactoryGirl.create(:user)
      login_as(user, scope: :user)

      user = FactoryGirl.create(:user)

      get edit_user_registration_path user
      expect(response).to render_template(:edit)

      patch user_registration_path, params: {
        user: {
          current_password: "userpassword",
          name: "My User Name",
          zipcode: 1234567,
          address: "My User Address",
          nickname: "My User Nickname"
        }
      }

      expect(response).to redirect_to(mypage_path)
      follow_redirect!

      expect(response).to render_template(:show)
    end
  end

  describe "GET /backoffice/users" do
    it "shows Users" do
      user = FactoryGirl.create(:admin)
      login_as(user, scope: :admin)

      get backoffice_users_path
      expect(response).to render_template(:index)
    end
  end

  describe "GET /backoffice/users/:id" do
    it "updates a User and redirects to the User's page" do
      user = FactoryGirl.create(:admin)
      login_as(user, scope: :admin)

      user = FactoryGirl.create(:user)

      get edit_backoffice_user_path user
      expect(response).to render_template(:edit)

      patch backoffice_user_path user, params: {
        user: {
          name: "My User Name Edit",
          zipcode: 7654321,
          address: "My User Address Edit"
        }
      }

      expect(response).to redirect_to([:backoffice, user])
      follow_redirect!

      expect(response).to render_template(:show)
      expect(response.body).to include("ユーザーが更新されました")
    end
  end

  describe "DELETE /backoffice/users/:id" do
    it "deletes a User and redirects to the User's page" do
      user = FactoryGirl.create(:admin)
      login_as(user, scope: :admin)

      user = FactoryGirl.create(:user)

      delete backoffice_user_path user
      expect(response).to redirect_to(backoffice_users_path)
      follow_redirect!

      expect(response).to render_template(:index)
      expect(response.body).to include("ユーザーが削除されました")
    end
  end
end
