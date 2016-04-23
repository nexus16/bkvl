# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.create!(user_name:  "Admin",
             email: "bkvl@gmail.com",
             password:              "12345678",
             password_confirmation: "12345678",
             admin: true)

10.times do |n|
  user_name  = Faker::Name.name
  email = "bkvl#{n+1}@gmail.com"
  password = "12345678"
  User.create!(user_name:  user_name,
               email: email,
               password:              password,
               password_confirmation: password,
               admin: false)
end
# Following relationships
users = User.all
user  = users.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }
