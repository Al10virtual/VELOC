# db/seeds.rb
puts "Cleaning database..."
Bike.destroy_all



puts "Creating bikes"

un = {user: User.first, bike_type: "vtc", wheel_size: "700cc", frame_material: "acier", brand: "Danone", condition: "mint", price_per_day: 11.5, price_per_week: 70 }
deux =  {user: User.second, bike_type: "route", wheel_size: "29 pouces", frame_material: "alu", brand: "Renault", condition: "dayly", price_per_day: 9, price_per_week: 50 }
trois = {user: User.first, bike_type: "cross", wheel_size: "26 pouces", frame_material: "alu", brand: "Apple", condition: "mint", price_per_day: 11.5, price_per_week: 70 }
quatre = {user: User.second, bike_type: "bmx", wheel_size: "12 pouces", frame_material: "acier", brand: "Giant", condition: "OK", price_per_day: 22.5, price_per_week: 110 }
cinq = {user: User.second, bike_type: "bmx", wheel_size: "14 pouces", frame_material: "carbon", brand: "Giant", condition: "OK", price_per_day: 18, price_per_week: 110 }


[un , deux, trois, quatre, cinq].each do |attributes|
  bike = Bike.create!(attributes)
  puts "Created #{bike.bike_type}"
end

puts "Finished!"
