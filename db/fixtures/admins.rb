(1...8).each do |i|
  Admin.seed(:id,
    {
      email: "test#{i}@example.com",
      password: "testtest"
    }
  )
end
