require 'rails_helper'

RSpec.describe "UserPoints", type: :request do
  describe "GET /coupons" do
    it "shows coupons" do
      user = FactoryGirl.create(:user)
      login_as(user, scope: :user)

      get coupons_path
      expect(response).to render_template(:index)
    end
  end

  describe "GET /coupons/:id/ and POST /user_points" do
    it "shows coupon and use coupon" do
      user = FactoryGirl.create(:user)
      login_as(user, scope: :user)

      coupon = FactoryGirl.create(:coupon)

      get coupon_path coupon

      expect(response).to render_template(:show)

      post user_points_path, params: {
        user_point: {
          coupon_id: coupon.id
        }
      }

      expect(response).to redirect_to(user_points_path)
      follow_redirect!

      expect(response).to render_template(:index)
      expect(response.body).to include("クーポンを使用しました")
    end
  end

  describe "GET /user_points" do
    it "shows user_points" do
      user = FactoryGirl.create(:user)
      login_as(user, scope: :user)

      get user_points_path
      expect(response).to render_template(:index)
    end
  end

  describe "GET /backoffice/users/:id/points/new" do
    it "adds user points and redirects to the User's page" do
      user = FactoryGirl.create(:admin)
      login_as(user, scope: :admin)

      user = FactoryGirl.create(:user)

      get new_backoffice_user_point_path user
      expect(response).to render_template(:new)

      post backoffice_user_points_path user, params: {
        user_point: {
          point: 1000
        }
      }

      expect(response).to redirect_to([:backoffice, user])
      follow_redirect!

      expect(response).to render_template(:show)
      expect(response.body).to include("ポイントを登録しました")
    end
  end
end
