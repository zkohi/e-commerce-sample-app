require 'rails_helper'

RSpec.describe "LineItems", type: :request do

  describe "POST /orders and DELETE /line_items/:id" do
    it "deletes a LineItem and redirects to the LineItem's page" do
      user = FactoryGirl.create(:user)
      login_as(user, scope: :user)

      product = FactoryGirl.create(:product)

      get product_path product
      expect(response).to render_template(:show)

      post orders_path, params: {
        order: {
          line_items_attributes: {
            "0": {
              product_id: product.id,
              quantity: 3
            }
          }
        }
      }

      expect(response).to redirect_to(cart_path)
      follow_redirect!

      expect(response).to render_template(:show)

      order = user.orders.find_or_initialize_by(state: :cart)

      delete line_item_path order.line_items.first
      expect(response).to redirect_to(cart_path)
      follow_redirect!

      expect(response).to render_template(:show)
      expect(response.body).to include("商品が削除されました")
    end
  end
end
