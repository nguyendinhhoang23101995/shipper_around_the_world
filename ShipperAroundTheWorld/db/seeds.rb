User.create!(name:  "Admin",
						 email: "nhom495itss@gmail.com",
						 password:              "barbar",
						 password_confirmation: "barbar",
						 phonenumber:           "0923984290",
						 admin: 				true,
						 activated: true,
						 activated_at: Time.zone.now)
User.create!(name:  "tuan",
						 email: "tuananhhedspibk@gmail.com",
						 password:              "123456",
						 password_confirmation: "123456",
						 phonenumber:           "0923921323",
						 activated: true,
						 activated_at: Time.zone.now)

User.create!(name:  "anh",
						 email: "tuananhhedspibk1@gmail.com",
						 password:              "123456",
						 password_confirmation: "123456",
						 phonenumber:           "0925921323",
						 activated: true,
						 activated_at: Time.zone.now)

User.create!(name:  "anhtt",
						 email: "tuan@mail.com",
						 password:              "123456",
						 password_confirmation: "123456",
						 phonenumber:           "0929921323",
						 activated: true,
						 activated_at: Time.zone.now)

User.create!(name:  "ttanh",
						 email: "anh@mail.com",
						 password:              "123456",
						 password_confirmation: "123456",
						 phonenumber:           "0825921323",
						 activated: true,
						 activated_at: Time.zone.now)

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
               phonenumber:           phonenumber,
               activated: true,
               activated_at: Time.zone.now)
end

ProductType.create!(name: "Mobile Phone")
ProductType.create!(name: "Television")
ProductType.create!(name: "Refrigrator")
ProductType.create!(name: "Stolen")
ProductType.create!(name: "Cars")
ProductType.create!(name: "Bike")
ProductType.create!(name: "Motor Bike")
ProductType.create!(name: "Sports equiment")

Origin.create!(name: "Japan")
Origin.create!(name: "America")
Origin.create!(name: "England")
Origin.create!(name: "Thailand")
Origin.create!(name: "Korean")
Origin.create!(name: "Australia")
Origin.create!(name: "France")
Origin.create!(name: "Germany")
Origin.create!(name: "Laos")
Origin.create!(name: "China")

BankAccount.create!(bank_account: "AAAA123", money: 20000)
BankAccount.create!(bank_account: "AABB1223", money: 10000)
BankAccount.create!(bank_account: "AAAA12222", money: 15000)
BankAccount.create!(bank_account: "AANN3838", money: 30000)