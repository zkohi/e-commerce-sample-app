require 'rails_helper'

RSpec.describe "Orders", type: :request do

  before :all do
    Timecop.freeze(Time.local(2017, 9, 4, 10, 5, 0))
  end

  after :all do
    Timecop.return
  end

  context "Cart is empty" do
    describe "GET /carts/edit" do
      it "redirects to a Cart" do
        user = FactoryGirl.create(:user)
        login_as(user, scope: :user)

        order = FactoryGirl.create(:order, :ordered)

        get edit_cart_path
        expect(response).to redirect_to(cart_path)
      end
    end
  end

  describe "DELETE /cart/line_items" do
    it "deletes a LineItem and redirects to the Cart page" do
      user = FactoryGirl.create(:user)
      login_as(user, scope: :user)

      product = FactoryGirl.create(:product)

      get product_path product
      expect(response).to render_template(:show)

      post cart_path, params: {
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

      expect(response).to render_template(:cart)

      order = user.orders.find_or_initialize_by(state: :cart)

      delete destroy_cart_line_item_path line_item_id: order.line_items.first.id
      expect(response).to redirect_to(cart_path)
      follow_redirect!

      expect(response).to render_template(:cart)
      expect(response.body).to include("商品が削除されました")
    end
  end

  describe "POST /cart and GET /cart and GET /cart/edit and PATCH /cart" do
    it "creates a Order, ListItem and redirects to the Cart page and orders" do
      user = FactoryGirl.create(:user)
      login_as(user, scope: :user)

      product = FactoryGirl.create(:product)

      get product_path product
      expect(response).to render_template(:show)

      post cart_path, params: {
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

      expect(response).to render_template(:cart)

      get edit_cart_path
      expect(response).to render_template(:edit)

      order = user.orders.find_or_initialize_by(state: :cart)
      patch cart_path, params: {
        order: {
          id: order.id,
          item_count: order.item_count,
          item_total: order.item_total,
          shipment_total: order.shipment_total,
          payment_total: order.payment_total,
          adjustment_total: order.adjustment_total,
          tax_total: order.tax_total,
          total: order.total,
          user_name: "My Order User Name",
          user_zipcode: 1234567,
          user_address: "My Order User Address",
          shipping_date: Date.today + 2,
          shipping_time_range: "twelve_to_fourteen",
          line_items_attributes: {
            "0": {
              id: order.line_items[0].id,
              product_id: order.line_items[0].product_id,
              quantity: order.line_items[0].quantity,
              price: order.line_items[0].product.price,
            }
          }
        }
      }

      expect(response).to redirect_to(order)
      follow_redirect!

      expect(response).to render_template(:show)
      expect(response.body).to include("ご注文完了しました")
    end
  end

  describe "GET /orders" do
    it "shows a Orders" do
      user = FactoryGirl.create(:user)
      login_as(user, scope: :user)

      order = FactoryGirl.create(:order, :ordered)

      get orders_path order
      expect(response).to render_template(:index)
    end
  end

  describe "GET /backoffice/orders" do
    it "shows Orders" do
      user = FactoryGirl.create(:admin)
      login_as(user, scope: :admin)

      FactoryGirl.create(:order, :ordered)

      get backoffice_orders_path
      expect(response).to render_template(:index)
    end
  end

  describe "GET /backoffice/orders/:id" do
    it "shows a Order" do
      user = FactoryGirl.create(:admin)
      login_as(user, scope: :admin)

      order = FactoryGirl.create(:order, :ordered)

      get backoffice_order_path order

      expect(response).to render_template(:show)
    end
  end
end
