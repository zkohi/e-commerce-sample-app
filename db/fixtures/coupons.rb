(1...8).each do |i|
  Coupon.seed(:id,
    {
      title: "Coupon ##{i}",
      code: "Coupon ##{i}",
      code: 3.times.map { ((0..9).to_a + ("a".."z").to_a + ("A".."Z").to_a).sample(4).join }.join("-"),
      point: i * 1000,
    }
  )
end
