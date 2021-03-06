require 'rails_helper'

RSpec.describe "Orders", type: :request do

  before :all do
    Timecop.freeze(Time.local(2017, 9, 4, 10, 5, 0))
  end

  after :all do
    Timecop.return
  end

  describe "DELETE /cart/line_items" do
    it "deletes a LineItem and redirects to the Cart page" do
      user = FactoryGirl.create(:user)
      login_as(user, scope: :user)

      product = FactoryGirl.create(:product_with_product_stocks)

      get product_path product
      expect(response).to render_template(:show)

      company_id = product.product_stocks.first.company_id
      post carts_path, params: {
        order: {
          company_id: company_id,
          line_items_attributes: [
            {
              product_id: product.id,
              quantity: 3
            }
          ]
        }
      }

      expect(response).to redirect_to(carts_path)
      follow_redirect!

      expect(response).to render_template(:cart)

      order = user.orders.find_or_initialize_by(state: :cart, company_id: company_id)

      delete line_items_cart_path order, line_item_id: order.line_items.first.id

      expect(response).to redirect_to(carts_path)
      follow_redirect!

      expect(response).to render_template(:cart)
      expect(response.body).to include("商品が削除されました")
    end
  end

  describe "POST /cart and GET /cart and GET /cart/edit and PATCH /cart" do
    it "creates a Order, ListItem and redirects to the Cart page and orders" do
      user = FactoryGirl.create(:user)
      login_as(user, scope: :user)

      product = FactoryGirl.create(:product_with_product_stocks)

      get product_path product
      expect(response).to render_template(:show)

      company_id = product.product_stocks.first.company_id
      post carts_path, params: {
        order: {
          company_id: company_id,
          line_items_attributes: [
            {
              product_id: product.id,
              quantity: 3
            }
          ]
        }
      }

      expect(response).to redirect_to(carts_path)
      follow_redirect!

      expect(response).to render_template(:cart)

      order = user.orders.find_or_initialize_by(state: :cart, company_id: company_id)

      get edit_cart_path order
      expect(response).to render_template(:edit)

      patch confirm_cart_path order, params: {
        order: {
          user_name: "My Order User Name",
          user_zipcode: 1234567,
          user_address: "My Order User Address",
          shipping_date: Date.today + 2,
          shipping_time_range: "twelve_to_fourteen",
          payment_type: "cash_on_delivery",
          line_items_attributes: [
            {
              id: order.line_items[0].id,
              product_id: order.line_items[0].product_id,
              quantity: order.line_items[0].quantity,
              price: order.line_items[0].product.price,
            }
          ]
        }
      }

      expect(response).to render_template(:confirm)

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
          payment_type: "cash_on_delivery",
          line_items_attributes: [
            {
              id: order.line_items[0].id,
              product_id: order.line_items[0].product_id,
              quantity: order.line_items[0].quantity,
              price: order.line_items[0].product.price,
            }
          ]
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

      order = FactoryGirl.create(:order, :ordered, user: user)

      get orders_path
      expect(response).to render_template(:index)
    end
  end

  describe "GET /orders/:id and PATCH /orders/:id/cancel and PATCH /orders/:id/reorder" do
    it "shows a Order and cancel order and reorder order" do
      user = FactoryGirl.create(:user)
      login_as(user, scope: :user)

      order = FactoryGirl.create(:order, :ordered, user: user)

      get order_path order
      expect(response).to render_template(:show)

      patch cancel_order_path order

      expect(response).to redirect_to(order_path(order))
      follow_redirect!

      expect(response).to render_template(:show)

      patch reorder_order_path order

      expect(response).to redirect_to(order_path(order))
      follow_redirect!

      expect(response).to render_template(:show)
    end
  end

  describe "GET /backoffice/orders" do
    it "shows Orders" do
      admin = FactoryGirl.create(:admin)
      login_as(admin, scope: :admin)

      FactoryGirl.create(:order, :ordered)

      get backoffice_orders_path
      expect(response).to render_template(:index)
    end
  end

  describe "GET /backoffice/orders/:id" do
    it "shows a Order" do
      admin = FactoryGirl.create(:admin)
      login_as(admin, scope: :admin)

      order = FactoryGirl.create(:order, :ordered)

      get backoffice_order_path order

      expect(response).to render_template(:show)
    end
  end

  describe "GET /companies/orders" do
    it "shows a Orders" do
      company = FactoryGirl.create(:company)
      login_as(company, scope: :company)

      order = FactoryGirl.create(:order, :ordered, company: company)

      get companies_orders_path
      expect(response).to render_template(:index)
    end
  end

  describe "GET /companies/orders/:id and PATCH PATCH /companies/orders/:id/cancel and PATCH /companies/orders/:id/reorder and /companies/orders/:id/prosessing and PATCH /companies/orders/:id/shipped" do
    it "shows a Order and cancel order and reorder and prosessing order and shipped order" do
      company = FactoryGirl.create(:company)
      login_as(company, scope: :company)

      order = FactoryGirl.create(:order, :ordered, company: company)

      get companies_order_path order
      expect(response).to render_template(:show)

      patch cancel_companies_order_path order

      expect(response).to redirect_to(companies_order_path(order))
      follow_redirect!

      expect(response).to render_template(:show)

      patch reorder_companies_order_path order

      expect(response).to redirect_to(companies_order_path(order))
      follow_redirect!

      expect(response).to render_template(:show)

      patch prosessing_companies_order_path order

      expect(response).to redirect_to(companies_order_path(order))
      follow_redirect!

      expect(response).to render_template(:show)

      patch shipped_companies_order_path order

      expect(response).to redirect_to(companies_order_path(order))
      follow_redirect!

      expect(response).to render_template(:show)
    end
  end

end
