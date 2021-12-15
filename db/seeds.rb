# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

#管理者権限のあるユーザを作成
User.create!(name: "John", email: "John@example.com",
            password: "foobar", password_confirmation: "foobar",
            admin: true)

#追加のユーザを作成
99.times do |n|
  name = Faker::Name.name 
  email = "example-#{n+1}@example.com"
  User.create!(name: name, email: email,
               password: "password", password_confirmation: "password")
end

users = User.order(:created_at).take(5)
50.times do
  title = Faker::Lorem.sentence(word_count: 4)
  body = Faker::Lorem.sentence(word_count: 10)
  users.each {|user| user.posts.create!(title: title, body: body)}
end