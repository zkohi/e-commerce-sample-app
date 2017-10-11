require 'rails_helper'

RSpec.describe "CouponUsers", type: :request do
  describe "GET /coupon_users" do
    it "works! (now write some real specs)" do
      get coupon_users_path
      expect(response).to have_http_status(200)
    end
  end
end
