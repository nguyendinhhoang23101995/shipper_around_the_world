User.create!(name:  "Example User",
						 email: "example@railstutorial.org",
						 password:              "foobar",
						 password_confirmation: "foobar",
						 phonenumber:           "0923984290")

30.times do |n|
	name  = Faker::Name.name
	email = "example-#{n+1}@railstutorial.org"
	password = "password"
		arr = [0]
		for i in 1...12 do
				arr.insert(i, rand(0..9))
		end

		phonenumber = arr.join('')
	User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password,
               phonenumber:           phonenumber)
end

ProductType.create!(name: "Mobile Phone")
ProductType.create!(name: "Television")
ProductType.create!(name: "Refrigrator")
ProductType.create!(name: "Stolen")
ProductType.create!(name: "Cars")
ProductType.create!(name: "Bike")
ProductType.create!(name: "Motor Bike")
ProductType.create!(name: "Sports equiment")