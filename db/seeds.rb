# User.all.destroy_all

User.create! name: 'Admin', email: 'admin@example.com', password: '123456', role: 'admin' if User.where(email: 'admin@example.com').empty?
User.create! name: 'Member', email: 'member@example.com', password: '123456', role: 'user' if User.where(email: 'member@example.com').empty?

puts "Created new users (admin, member)"

10.times do
user = User.create! name: Faker::Internet.username, email: Faker::Internet.email, password: '123456', role: 'user'
puts "Created a new user: #{user.name} (#{user.email})"
end