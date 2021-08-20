User.all.destroy_all

User.create! name: 'Admin', email: 'admin@example.com', password: '123456', role: 'admin'
User.create! name: 'Member', email: 'member@example.com', password: '123456', role: 'user'

puts "User created successfully"