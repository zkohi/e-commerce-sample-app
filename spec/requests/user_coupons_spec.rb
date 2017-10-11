require 'rails_helper'

RSpec.describe "UserCoupons", type: :request do
  describe "GET /user_coupons" do
    it "works! (now write some real specs)" do
      get user_coupons_path
      expect(response).to have_http_status(200)
    end
  end
end
