# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'
require "open-uri"

Faker::Config.locale = "en-CA"

User.destroy_all

password = "testtest"

User.create! [
	email: "decorator@test.com",
	# password_digest: User.new(:password => password).password_digest,
	password: password,
	password_confirmation: password,
]

User.create! [
	email: "nick@test.com",
	# password_digest: User.new(:password => password).password_digest,
	password: password,
	password_confirmation: password,
]



p "Created #{User.count} users"

Project.destroy_all
3.times do
	Project.create! [
		name: Faker::Company.name,
		user_id: 2,
		budget: Faker::Number.between(10000, 100000),
	]
end
p "Created #{Location.count} sets"

Location.destroy_all
20.times do
	Location.create! [
		name: Faker::Hobbit.location,
		street: Faker::Address.street_address,
		city: Faker::Address.city,
		postal: "X1X 1X1",
		province: "British Columbia",
		project_id: Project.all.sample.id,
		interior: Faker::Boolean.boolean,

	]
end
p "Created #{Location.count} sets"

Rental.destroy_all

150.times do
	Rental.create! [
		image: File.open(Dir['public/uploads/1.jpeg', 'public/uploads/2.jpeg', 'public/uploads/3.png', 'public/uploads/4.jpg', 'public/uploads/5.jpg'].sample),

		desc: Faker::Commerce.product_name,
		rental: Faker::Boolean.boolean,
		source: Faker::Friends.location,
		due_date: Faker::Date.between(50.days.ago, Date.today),
		location_id: Location.all.sample.id,
		project_id: Project.all.sample.id

	]
end
p "Created #{Rental.count} rentals"

Budget.destroy_all
20.times do
	Budget.create! [
		location_id: Location.all.sample.id,
		project_id: Project.all.sample.id
	]
end
p "Created #{Budget.count} budgets"
budgets = Budget.all
budgets.each do |bud|
	quest_count = 1
	10.times do
		BudgetItem.new(
		budget_id: bud.id,
		item: Faker::Zelda.item,
		rental: Faker::Boolean.boolean,
		price: Faker::Commerce.price,
	).save(validate: false)
	quest_count +=1
	end

end
p "Created #{BudgetItem.count} budget items"

Crew.destroy_all
30.times do
	Crew.create! [
		name: Faker::Seinfeld.character,
		phone: Faker::PhoneNumber.cell_phone,
		email: Faker::Internet.email,
		availability: Faker::Hacker.adjective,
		skills: Faker::MostInterestingManInTheWorld.quote,
		notes: Faker::RickAndMorty.quote,

	]
end

p "Created #{Crew.count} crew members"