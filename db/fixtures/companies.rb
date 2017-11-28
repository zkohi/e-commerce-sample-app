(1...8).each do |i|
  Company.seed(:id,
    {
      email: "test#{i}@example.com",
      password: "testtest",
      name: "Company ##{i}",
      quantity_per_box: i
    }
  )
end
