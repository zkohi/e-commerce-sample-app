(1...8).each do |i|
  User.seed(:id,
    {
      email: "test#{i}@example.com",
      password: "testtest",
      nickname: "User ##{i} Nickname",
      name: "User ##{i}",
      zipcode: Faker::Number.number(7),
      address: "User ##{i} Address"
    }
  )
end
