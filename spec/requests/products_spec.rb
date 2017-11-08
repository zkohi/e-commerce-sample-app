require 'rails_helper'

RSpec.describe "Products", type: :request do

  describe "GET /products" do
    it "shows Products" do
      user = FactoryGirl.create(:user)
      login_as(user, scope: :user)

      get products_path
      expect(response).to render_template(:index)
    end
  end

  describe "GET /products/:id" do
    it "shows Product" do
      user = FactoryGirl.create(:user)
      login_as(user, scope: :user)

      product = FactoryGirl.create(:product)

      get product_path product
      expect(response).to render_template(:show)
    end
  end

  describe "GET /backoffice/products" do
    it "shows Products" do
      user = FactoryGirl.create(:admin)
      login_as(user, scope: :admin)

      get backoffice_products_path
      expect(response).to render_template(:index)
    end
  end

  describe "GET /backoffice/products/new" do
    it "creates a Product and redirects to the Product's page" do
      user = FactoryGirl.create(:admin)
      login_as(user, scope: :admin)

      get new_backoffice_product_path
      expect(response).to render_template(:new)

      post backoffice_products_path, params: {
        product: {
          name: "My Product",
          price: 12345,
          description: "My Product Description",
          flg_non_display: "display",
          sort_order: 10
        }
      }

      expect(response).to redirect_to([:backoffice, assigns(:product)])
      follow_redirect!

      expect(response).to render_template(:show)
      expect(response.body).to include("商品が作成されました")
    end
  end

  describe "GET /backoffice/products/:id" do
    it "updates a Product and redirects to the Product's page" do
      user = FactoryGirl.create(:admin)
      login_as(user, scope: :admin)

      product = FactoryGirl.create(:product)

      get edit_backoffice_product_path product
      expect(response).to render_template(:edit)

      patch backoffice_product_path product, params: {
        product: {
          name: "My Product Edit",
          price: 123456,
          description: "My Product Description Edit",
          flg_non_display: "non_display",
          sort_order: 100
        }
      }

      expect(response).to redirect_to([:backoffice, product])
      follow_redirect!

      expect(response).to render_template(:show)
      expect(response.body).to include("商品が更新されました")
    end
  end

  describe "DELETE /backoffice/products/:id" do
    it "deletes a Product and redirects to the Product's page" do
      user = FactoryGirl.create(:admin)
      login_as(user, scope: :admin)

      product = FactoryGirl.create(:product)

      delete backoffice_product_path product
      expect(response).to redirect_to(backoffice_products_path)
      follow_redirect!

      expect(response).to render_template(:index)
      expect(response.body).to include("商品が削除されました")
    end
  end
end
