harry = User.create!(first_name: 'Harry', last_name: 'Potter', email: 'wizard@hogwarts.com', street_address: '3722 Crenshaw Blvd.', city: 'Los Angeles', state: 'CA', zip_code: '90016', password: 'verysecurepassword')
mariah = User.create!(first_name: 'Mariah', last_name: 'Carey', email: 'alliwantforxmas@example.com', street_address: '3722 Crenshaw Blvd.', city: 'Los Angeles', state: 'CA', zip_code: '90016', password: 'ultrasecurepassword')

station1 = Station.create!(api_id:"152087")
station2 = Station.create!(api_id:"152070")

favorite_station1 = UserStation.create!(user_id: harry.id, station_id: station1.id)
favorite_station2 = UserStation.create!(user_id: harry.id, station_id: station2.id)
