# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# User.destroy_all

bill = User.create(first_name: 'Bill', last_name: 'Seldon', email: 'email@example.com', street_address: 'st', city: 'c', state: 's', zip_code: 'zc', password: 'verysecurepassword')
elon = User.create(first_name: 'Elon', last_name: 'Musk', email: 'electric@example.com', street_address: '123 Street', city: 'Los Angeles', state: 'CA', zip_code: '90210', password: 'ultrasecurepassword')

station1 = Station.create(api_id:"152087")
station2 = Station.create(api_id:"152070")

favorite_station1 = UserStation.create(user_id: bill.id, station_id: station1.id)
favorite_station2 = UserStation.create(user_id: bill.id, station_id: station2.id)
