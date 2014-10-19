# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


Person.where(first_name: "Charles-André", surname: "Bouffard", position: "Programmer").first_or_create
Person.where(first_name: "Jean-Philippe", surname: "Goulet", position: "Programmer").first_or_create
Person.where(first_name: "Alex", surname: "Nault", position: "Designer").first_or_create
