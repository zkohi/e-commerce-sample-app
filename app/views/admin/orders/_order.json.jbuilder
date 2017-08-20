json.extract! order, :id, :user_id, :state, :shipment_state, :payment_state, :item_count, :item_total, :shipment_total, :payment_total, :tax_total, :total, :created_at, :updated_at
json.url order_url(order, format: :json)
