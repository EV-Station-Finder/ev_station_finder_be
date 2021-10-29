# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
include FactoryBot::Syntax::Methods

User.destroy_all

bill = create(:user, first_name: 'Bill', last_name: 'Seldon', email: 'email@example.com', street_address: 'st', city: 'c', state: 's', zip_code: 'zc', password: 'verysecurepassword')

