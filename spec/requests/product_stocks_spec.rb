require 'rails_helper'

RSpec.describe "ProductStocks", type: :request do
  describe "GET /companies/products" do
    it "shows Products" do
      user = FactoryGirl.create(:company)
      login_as(user, scope: :company)

      get companies_products_path
      expect(response).to render_template(:index)
    end
  end

  describe "GET /companies/products/:id and POST /companies/products/:id/stocks" do
    it "shows Product" do
      user = FactoryGirl.create(:company)
      login_as(user, scope: :company)

      product = FactoryGirl.create(:product)

      get companies_product_path product
      expect(response).to render_template(:show)

      post companies_product_stocks_path product, params: {
        product_stock: {
          stock: 10
        }
      }

      expect(response).to redirect_to(companies_product_path(product))
      follow_redirect!

      expect(response).to render_template(:show)
      expect(response.body).to include("商品在庫が登録されました")
    end
  end

  describe "GET /companies/stocks" do
    it "shows ProductStocks" do
      user = FactoryGirl.create(:company)
      login_as(user, scope: :company)

      get companies_stocks_path
      expect(response).to render_template(:stocks)
    end
  end

  describe "DELETE /companies/products/:product_id/stocks/:id" do
    it "deletes a ProductStock and redirects to the ProductStock's page" do
      user = FactoryGirl.create(:company)
      login_as(user, scope: :company)

      product_stock = FactoryGirl.create(:product_stock)

      delete companies_product_stock_path product_stock.product_id, product_stock
      expect(response).to redirect_to(companies_stocks_path)
      follow_redirect!

      expect(response).to render_template(:stocks)
      expect(response.body).to include("商品在庫が削除されました")
    end
  end
end
