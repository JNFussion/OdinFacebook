# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
100.times do
  User.create(
    email: Faker::Internet.unique.safe_email,
    username: Faker::Internet.unique.username,
    password: '123456789',
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    birth_date: Faker::Date.birthday(min_age: 18, max_age: 65),
    nationality: Faker::Address.country_code,
    phone_number: Faker::PhoneNumber.cell_phone
  )
end
