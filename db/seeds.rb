# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

#adminユーザを作成
User.create!(name: "John", email: "John@example.com",
            password: "foobar",
            password_confirmation: "foobar",
            admin: true)

# #追加のユーザを作成
# 99.times do |n|
#   name = Faker::Name.name 
#   email = "example-#{n+1}@example.com"
#   User.create!(name: name, email: email,
#                password: "password",
#                password_confirmation: "password")
# end

# # postを作成
# users = User.order(:created_at).take(5)
# categories = ["japanese", "math", "science", "social", "foreign lang", "others"]
# 50.times do
#   title = Faker::Lorem.sentence(word_count: 5)
#   body = Faker::Lorem.sentence(word_count: 1000)
#   category = categories.sample
#   users.each {|user| user.posts.create!(title: title, body: body, category: category)}
# end

# # commentを作成
# users = User.order(:created_at).take(5)
# 20.times do
#   content = Faker::Lorem.sentence(word_count: 100)
#   users.each {|user| user.comments.create!(content: content,
#                       post_id: user.posts.first.id)}
# end