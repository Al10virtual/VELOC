require "open-uri"

puts "Cleaning database..."
Bike.destroy_all
User.destroy_all
Rental.destroy_all

puts "Creating users"

first_user = {  first_name: "jerry",
                last_name: "ahn",
                email: "toto@gmail.com",
                password: "azerty",
                address: "61 Rue Oberkampf, 75011 Paris" }
second_user = { first_name: "tom",
                last_name: "hatt",
                email: "tutu@gmail.com",
                password: "azerty",
                address: "30 R. de Lévis, 75017 Paris" }
third_user = {  first_name: "jean",
                last_name: "bon",
                email: "titit@gmail.com",
                password: "azerty",
                address: "Rue de la Croix Nivert, 75015 Paris" }
fourth_user = { first_name: "laure",
                last_name: "attika",
                email: "tutut@gmail.com",
                password: "azerty",
                address: "67 Rue Mademoiselle, 75015 Paris" }

[first_user, second_user, third_user, fourth_user].each do |attributes|
  user = User.create!(attributes)
  puts "Created #{user.email}"
end

puts "Creating bikes"

first_bike = {    user: User.first,
                  bike_type: "Vélo ville",
                  wheel_size: "700c",
                  frame_material: "Aluminium",
                  brand: "Canyon",
                  model: "Roadlite",
                  is_electric: false,
                  condition: "Bon état",
                  address: "114 Av. des Champs-Élysées, 75008 Paris",
                  price_per_day: 11.5,
                  price_per_week: 70 }
second_bike = {   user: User.second,
                  bike_type: "Vélo route",
                  wheel_size: "700c",
                  frame_material: "Carbone",
                  brand: "Decathlon",
                  model: "Btwin Triban",
                  is_electric: false,
                  condition: "Très bon état",
                  address: "12 villa Gaudelet, 75016 Paris",
                  price_per_day: 9,
                  price_per_week: 50 }
third_bike = {    user: User.third,
                  bike_type: "Vélo cargo",
                  wheel_size: "26\"",
                  frame_material: "Aluminium",
                  brand: "Decathlon",
                  model: "R500Elec",
                  is_electric: true,
                  condition: "Bon état",
                  address: "3 avenue Mozart, 75016 Paris",
                  price_per_day: 11.5,
                  price_per_week: 70 }
fourth_bike = {   user: User.fourth,
                  bike_type: "Bmx", wheel_size: "16\"",
                  frame_material: "Aluminium",
                  brand: "Giant",
                  model: "Explore E+",
                  is_electric: true,
                  condition: "État satisfaisant",
                  address: "31 boulevard Beausejour, 75016 Paris",
                  price_per_day: 22.5,
                  price_per_week: 110 }
fifth_bike = {    user: User.third,
                  bike_type: "Vélo tout terrain",
                  wheel_size: "27.5\"",
                  frame_material: "Aluminium",
                  brand: "Orbea",
                  model: "Alma",
                  is_electric: false,
                  condition: "État neuf",
                  address: "16 Villa Gaudelet, 75011 Paris",
                  price_per_day: 25,
                  price_per_week: 150 }

[first_bike, second_bike, third_bike, fourth_bike, fifth_bike].each do |attributes|
  url = "https://api.unsplash.com/photos/random?client_id=#{ENV["ACCESS_KEY"]}&query=bicycle&orientation=landscape"
  photo_serialized = URI.open(url).read
  photo_json = JSON.parse(photo_serialized)
  photo_url = photo_json["urls"]["small"]
  file = URI.open(photo_url)
  bike = Bike.new(attributes)
  bike.photo.attach(
    io: file,
    filename: "bike.jpg",
    content_type: "image/jpg"
  )
  bike.save!
  puts "Created #{bike.brand} #{bike.model} "
end

puts "Creating rentals"

first_rental = Rental.new(
  total_price: 11,
  start_date: "2023-01-01",
  end_date: "2023-01-15",
  status: "pending"
)
first_rental.user = User.first
first_rental.bike = Bike.second
first_rental.save!

second_rental = Rental.new(
  total_price: 22,
  start_date: "2023-02-01",
  end_date: "2023-02-15",
  status: "accepted"
)
second_rental.user = User.second
second_rental.bike = Bike.third
second_rental.save!

third_rental = Rental.new(
  total_price: 33,
  start_date: "2023-03-01",
  end_date: "2023-03-15",
  status: "pending"
)
third_rental.user = User.third
third_rental.bike = Bike.fourth
third_rental.save!

fourth_rental = Rental.new(
  total_price: 44,
  start_date: "2023-04-01",
  end_date: "2023-04-15",
  status: "pending"
)
fourth_rental.user = User.fourth
fourth_rental.bike = Bike.first
fourth_rental.save!

puts "Finished!"
