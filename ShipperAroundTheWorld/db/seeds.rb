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

users = User.order(:created_at).take(6)
50.times do
	content = Faker::Lorem.sentence(5)
	users.each { |user| user.requests.create!(content: content) }
end

10.times do
	content = Faker::Lorem.sentence(5)
	ProductType.create!(name: content)
end