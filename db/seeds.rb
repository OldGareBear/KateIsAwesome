# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

100.times do 
  Message.create!(
    body: Faker::Lorem.sentence, 
    city: "NYC", 
    from: "+" + Faker::Number.number(10), 
    state: "NY", 
    created_at: Time.now, 
    updated_at: Time.now
  )
end