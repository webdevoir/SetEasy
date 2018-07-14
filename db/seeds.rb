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
p "Created #{Project.count} projects"

Location.destroy_all
20.times do
	Location.create! [
		name: Faker::Hobbit.unique.location,
		street: Faker::Address.street_address,
		city: Faker::Address.city,
		postal: "X1X 1X1",
		province: "British Columbia",
		project_id: Project.all.sample.id,
		interior: Faker::Boolean.boolean,

	]
end
p "Created #{Location.count} sets"



Budget.destroy_all
# 20.times do
Location.all.each do |loc|
	Budget.create! [
		location_id: loc.id,
		project_id: loc.project_id
	]
end
p "Created #{Budget.count} budgets"
# budgets = Budget.all
# budgets.each do |bud|
# 	quest_count = 1
# 	10.times do
# 		BudgetItem.new(
# 		budget_id: bud.id,
# 		item: Faker::Zelda.item,
# 		rental: Faker::Boolean.boolean,
# 		price: Faker::Commerce.price,
# 	).save(validate: false)
# 	quest_count +=1
# 	end

# end

Rental.destroy_all

rentid = 1
150.times do
	Rental.create! [
		image: File.open(Dir['public/uploads/1.jpeg', 'public/uploads/2.jpeg', 'public/uploads/3.png', 'public/uploads/4.jpg', 'public/uploads/5.jpg'].sample),
		# desc: Faker::Commerce.product_name,
		# rental: Faker::Boolean.boolean,
		source: Faker::Friends.location,
		due_date: Faker::Date.between(50.days.ago, Date.today),
		pick_date:  Faker::Date.between(50.days.ago, Date.today),
		location_id: Location.all.sample.id,
		project_id: Project.all.sample.id
	]
	@rental = Rental.last
	set = @rental.location_id
	@budget = Budget.find_by(location_id: @rental.location)
	# budget_price = Faker::Commerce.price,
	p @rental.desc
	BudgetItem.create!(budget_id: @budget.id, item: Faker::Commerce.product_name, price: Faker::Commerce.price, rent_status: Faker::Boolean.boolean, rental_id: rentid)
	rentid += 1
end
p "Created #{Rental.count} rentals"
p "Created #{BudgetItem.count} budget items"

Crew.destroy_all
roles = [
              "Production Designer",
              "Decorator",
              "Asst. Decorator",
              "Coordinator",
              "Buyer",
              "Lead Dresser",
              "Driver",
              "Swamper",
              "Dresser"
            ]
30.times do
	Crew.create! [
		name: Faker::Seinfeld.character,
		phone: Faker::PhoneNumber.cell_phone,
		email: Faker::Internet.email,
		availability: Faker::Hacker.adjective,
		skills: Faker::MostInterestingManInTheWorld.quote,
		notes: Faker::RickAndMorty.quote,
		project_id: Project.all.sample.id,
		role: roles.sample

	]
end

p "Created #{Crew.count} crew members"

Event.destroy_all
100.times do
	project = Project.all.sample
	crew_arr = []
	num = Faker::Number.between(1, 5)
	num.times do
		crew_arr.push(Crew.all.sample.id)
	end
	start = Faker::Time.between(2.weeks.ago, 3.weeks.from_now, :day)
	title = ["Prep", "Dress", "Wrap"].sample
	  case title
	      when "Prep"
	        color = 'blue'
	      when "Dress"
	        color = '#cec400'
	      when "Wrap"
	        color = 'orange'
	      else
	        color = 'red'
	    end
	
	Event.create! [
		title: title,
		project_id: project.id,
		crew_ids: crew_arr,
		location_id: project.locations.sample.id,
		start: start,
		end: start + 2.hours,
		color: color
		

	]
end

p "Created #{Event.count} events"