#Users
User.create!(name: "Boo Mc.Boo",
	         email: "example@test.com",
	         password: "testtest",
	         password_confirmation: "testtest")

99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@yahoo.com"
  password = "password"
  User.create!(name: name,
              email: email,
              password:              password,
              password_confirmation: password,)
end