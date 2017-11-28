(1...8).each do |i|
  Diary.seed(:id,
    {
      user_id: (i % 3) + 1,
      title: "Title ##{i}",
      content: "Content ##{i}"
    }
  )
end
