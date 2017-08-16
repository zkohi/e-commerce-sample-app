json.extract! product, :id, :name, :filename, :price, :description, :flg_non_display, :sort_order, :created_at, :updated_at
json.url product_url(product, format: :json)
