# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

jesus = User.create(username: 'Jesus', email: 'jesus@example.com', password: 'password')
rhubarb = User.create(username: 'Rhubarb', email: 'rhubarb@example.com', password: 'password')
muenster = User.create(username: 'Muenster', email: 'muenster@example.com', password: 'password')
aleks = User.create(username: 'Aleks', email: 'aleks@example.com', password: 'password')

jesus.friends << [rhubarb, muenster]

jesus.posts.build(body: 'test post').save
muenster.posts.build(body: 'another post').save
rhubarb.posts.build(body: 'meow meow').save
