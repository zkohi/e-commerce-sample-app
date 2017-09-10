(1...8).each do |i|
  Product.seed(:id,
    {
      name: "Product ##{i}",
      img_filename: '',
      price: i * 1000,
      description: "A product ##{i}.",
      flg_non_display: "display",
      sort_order: i
    }
  )
end
