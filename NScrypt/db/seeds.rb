# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

u = User.new legal_name: 'Administrator', username: 'admin', email: 'admin@crypto-law.com', password: 'Krypt0law', password_confirmation: 'Krypt0law' do |u|
  u.role = 'admin'
  u.confirmed_at = DateTime.now
  u.confirmation_sent_at = DateTime.now
end
u.save!

