10.times do |n|
  User.create(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, description: Faker::Lorem.sentence(word_count: 50 + rand(150)), email: "user#{n += 1}@yopmail.com")
end