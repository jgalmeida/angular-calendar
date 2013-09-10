# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

100.times do |i|
  2.times do 
    Event.create  date: (Date.today + i.days), 
                  hour: Time.now + 60,
                  name: Faker::Name.name,
                  location: Faker::Address.street_address,
                  description: Faker::Lorem.sentence
  end
end

puts "FINISHED"