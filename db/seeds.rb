require 'securerandom'
require 'json'

Rake::Task['db:seed_base'].invoke
Rake::Task['db:seed_states'].invoke
puts "Data seeded, questions has been created!"

User.create!(
  email: ENV['ADMIN_EMIAL'],
  password: ENV['ADMIN_PASSWORD'],
  password_confirmation: ENV['ADMIN_PASSWORD'],
  role: :admin
) unless User.exists?(email: ENV['ADMIN_EMAIL'])
puts "User admin has been created!"
