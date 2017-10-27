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

  describe "GET /coupons/:id/ and POST /points" do
    it "shows coupon and use coupon" do
      user = FactoryGirl.create(:user)
      login_as(user, scope: :user)

      coupon = FactoryGirl.create(:coupon)

      get coupon_path coupon

      expect(response).to render_template(:show)

      post points_path, params: {
        user_point: {
          coupon_id: coupon.id
        }
      }

      expect(response).to redirect_to(points_path)
      follow_redirect!

      expect(response).to render_template(:points)
      expect(response.body).to include("クーポンを使用しました")
    end
  end

  describe "GET /points" do
    it "shows points" do
      user = FactoryGirl.create(:user)
      login_as(user, scope: :user)

      get points_path
      expect(response).to render_template(:points)
    end
  end
end
