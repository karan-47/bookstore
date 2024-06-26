# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

admin = User.create(username:"admin",name:"admin",email:"admin@gmail.com",creditcardnumber:"1111111111111111",phonenumber:"1111111111",password:"admin", address:"NCSU")

user1 = User.create(username:"Karan",name:"karan",email:"kgala2@ncsu.edu",creditcardnumber:"9999999999999999",phonenumber:"1111111111",password:"1234",address:"1411 stovall dr")
user2 = User.create(username:"User2",name:"Test",email:"test@ncsu.edu",creditcardnumber:"8888888888888888",phonenumber:"2222222222",password:"1234",address:"1411 stovall dr")