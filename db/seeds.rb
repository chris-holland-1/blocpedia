# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'random_data'

# Create Users
5.times do
  User.create!(
    name:     RandomData.random_name,
    email:    RandomData.random_email,
    password: RandomData.random_sentence
  )
end
users = User.all

# Create Wikis
 50.times do
   Wiki.create!(
     user:   users.sample,
     title:  RandomData.sentence,
     body:   RandomData.paragraph
   )
 end
 wikis = Wiki.all

# Create an admin user
 admin = User.create!(
   name:     'Admin User',
   email:    'admin@example.com',
   password: 'helloworld',
   role: 'admin'
 )

 # Create a standard user
 standard = User.create!(
   name:     'Standard User',
   email:    'standard@example.com',
   password: 'helloworld'
 )

 # Create a premium user
 premium = User.create!(
   name:     'Premium User',
   email:    'premium@example.com',
   password: 'helloworld'
 )

puts "Seed finished"
puts "#{User.count} users created"
puts "#{Wiki.count} wiki created"
puts "Admin user created"
puts "Standard user created"
puts "Premium user created"
