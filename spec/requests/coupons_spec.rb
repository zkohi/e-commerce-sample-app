require 'rails_helper'

RSpec.describe "Coupons", type: :request do

  describe "GET /backoffice/coupons" do
    it "shows Companies" do
      user = FactoryGirl.create(:admin)
      login_as(user, scope: :admin)

      get backoffice_coupons_path
      expect(response).to render_template(:index)
    end
  end

  describe "GET /coupons/:id" do
    it "shows Coupon" do
      user = FactoryGirl.create(:admin)
      login_as(user, scope: :admin)

      coupon = FactoryGirl.create(:coupon)

      get backoffice_coupon_path coupon
      expect(response).to render_template(:show)
    end
  end

  describe "GET /backoffice/coupons/new" do
    it "creates a Coupon and redirects to the Coupon's page" do
      user = FactoryGirl.create(:admin)
      login_as(user, scope: :admin)

      get new_backoffice_coupon_path
      expect(response).to render_template(:new)

      post backoffice_coupons_path, params: {
        coupon: {
          title: "My Coupon Title",
          code: "1234-5678-90ab",
          point: 1000
        }
      }

      expect(response).to redirect_to([:backoffice, assigns(:coupon)])
      follow_redirect!

      expect(response).to render_template(:show)
      expect(response.body).to include("クーポンが作成されました")
    end
  end

  describe "GET /backoffice/coupons/:id" do
    it "updates a Coupon and redirects to the Coupon's page" do
      user = FactoryGirl.create(:admin)
      login_as(user, scope: :admin)

      coupon = FactoryGirl.create(:coupon)

      get edit_backoffice_coupon_path coupon
      expect(response).to render_template(:edit)

      patch backoffice_coupon_path coupon, params: {
        coupon: {
          title: "My Coupon Title Eidt",
          code: "1234-5678-90cd",
          point: 2000
        }
      }

      expect(response).to redirect_to([:backoffice, coupon])
      follow_redirect!

      expect(response).to render_template(:show)
      expect(response.body).to include("クーポンが更新されました")
    end
  end

  describe "DELETE /backoffice/coupons/:id" do
    it "deletes a Coupon and redirects to the Coupon's page" do
      user = FactoryGirl.create(:admin)
      login_as(user, scope: :admin)

      coupon = FactoryGirl.create(:coupon)

      delete backoffice_coupon_path coupon
      expect(response).to redirect_to(backoffice_coupons_path)
      follow_redirect!

      expect(response).to render_template(:index)
      expect(response.body).to include("クーポンが削除されました")
    end
  end
end
