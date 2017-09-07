require 'rails_helper'

RSpec.describe "Users", type: :request do

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
          address: "My User Address"
        }
      }

      expect(response).to redirect_to(mypage_path)
      follow_redirect!

      expect(response).to render_template(:show)
    end
  end

  describe "GET /admin/users" do
    it "shows Users" do
      user = FactoryGirl.create(:admin)
      login_as(user, scope: :admin)

      get admin_users_path
      expect(response).to render_template(:index)
    end
  end

  describe "GET /admin/users/:id" do
    it "updates a User and redirects to the User's page" do
      user = FactoryGirl.create(:admin)
      login_as(user, scope: :admin)

      user = FactoryGirl.create(:user)

      get edit_admin_user_path user
      expect(response).to render_template(:edit)

      patch admin_user_path user, params: {
        user: {
          name: "My User Name Edit",
          zipcode: 7654321,
          address: "My User Address Edit"
        }
      }

      expect(response).to redirect_to([:admin, user])
      follow_redirect!

      expect(response).to render_template(:show)
      expect(response.body).to include("ユーザーが更新されました")
    end
  end

  describe "DELETE /admin/users/:id" do
    it "deletes a User and redirects to the User's page" do
      user = FactoryGirl.create(:admin)
      login_as(user, scope: :admin)

      user = FactoryGirl.create(:user)

      delete admin_user_path user
      expect(response).to redirect_to(admin_users_path)
      follow_redirect!

      expect(response).to render_template(:index)
      expect(response.body).to include("ユーザーが削除されました")
    end
  end
end
