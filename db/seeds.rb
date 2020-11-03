require 'faker'

5.times do |n|
  User.create(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, description: Faker::Lorem.sentence(word_count: 50 + rand(150)), email: "user#{n += 1}@yopmail.com")
end

5.times do
  Event.create(start_date: DateTime.now + 60, title: Faker::Movie.title, duration: [15, 30, 60].sample, description: Faker::Lorem.sentence(word_count: 50 + rand(20)), price: Faker::Number.between(from: 15, to: 99), location: Faker::Address.city, event_admin: User.all.sample)
end