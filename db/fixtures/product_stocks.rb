(1...8).each do |i|
  (1..i).each do |j|
    ProductStock.seed(:id,
      {
        product_id: i,
        company_id: j,
        stock: Faker::Number.between(1, 999999)
      }
    )
  end
end
