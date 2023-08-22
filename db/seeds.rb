# db/seeds.rb
puts "Cleaning database..."
Bike.destroy_all
User.destroy_all
Rental.destroy_all

puts "Creating users"

first_user = { email: "toto@gmail.com", password: "azerty" }
second_user = { email: "tutu@gmail.com", password: "azerty" }
third_user = { email: "titit@gmail.com", password: "azerty" }
fourth_user = { email: "tutut@gmail.com", password: "azerty" }

[first_user, second_user, third_user, fourth_user].each do |attributes|
  user = User.create!(attributes)
  puts "Created #{user.email}"
end

puts "Creating bikes"

first_bike = { user: User.first, bike_type: "vtc", wheel_size: "700cc", frame_material: "acier", brand: "Danone", condition: "mint", price_per_day: 11.5, price_per_week: 70 }
second_bike =  { user: User.second, bike_type: "route", wheel_size: "29 pouces", frame_material: "alu", brand: "Renault", condition: "dayly", price_per_day: 9, price_per_week: 50 }
third_bike = { user: User.third, bike_type: "cross", wheel_size: "26 pouces", frame_material: "alu", brand: "Apple", condition: "mint", price_per_day: 11.5, price_per_week: 70 }
fourth_bike = { user: User.fourth, bike_type: "bmx", wheel_size: "12 pouces", frame_material: "acier", brand: "Giant", condition: "OK", price_per_day: 22.5, price_per_week: 110 }
fifth_bike = { user: User.third, bike_type: "bmx", wheel_size: "14 pouces", frame_material: "carbon", brand: "Giant", condition: "OK", price_per_day: 18, price_per_week: 110 }

[first_bike, second_bike, third_bike, fourth_bike, fifth_bike].each do |attributes|
  bike = Bike.create!(attributes)
  puts "Created #{bike.bike_type}"
end

puts "Creating rentals"

first_rental = Rental.new(total_price: 11.5, start_date: "2023-08-25", end_date: "2023-08-26", status: "pending")
first_rental.user = User.first
first_rental.bike = Bike.first
first_rental.save!

second_rental = Rental.new(total_price: 70, start_date: "2023-09-12", end_date: "2023-09-19", status: "accepted")
second_rental.user = User.fourth
second_rental.bike = Bike.second
second_rental.save!

third_rental = Rental.new(total_price: 11.5, start_date: "2023-10-03", end_date: "2023-10-04", status: "refused")
third_rental.user = User.third
third_rental.bike = Bike.third
third_rental.save!

puts "Finished!"
