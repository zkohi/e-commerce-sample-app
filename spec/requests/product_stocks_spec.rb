require 'rails_helper'

RSpec.describe "ProductStocks", type: :request do
  describe "GET /product_stocks" do
    it "works! (now write some real specs)" do
      get product_stocks_path
      expect(response).to have_http_status(200)
    end
  end
end
