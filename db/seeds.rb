(1...5).each do |i|
  Product.create(
    name: "Product ##{i}",
    img_filename: '',
    price: i * 1000,
    description: "A product ##{i}.",
    flg_non_display: "Product ##{i}",
    sort_order: i
  )
end
