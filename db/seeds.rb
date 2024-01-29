# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

categories = Categories.create([{name: "Chest", description:"Chest exercises", user_id: nil }, {name: "Back", description:"Back exercises", user_id: nil }, {name: "Legs", description:"Leg exercises", user_id: nil }, {name: "Shoulders", description:"Shoulder exercises", user_id: nil }, {name: "Biceps", description:"Bicep exercises", user_id: nil }, {name: "Triceps", description:"Tricep exercises", user_id: nil }, {name: "Abs", description:"Core exercises", user_id: nil }])
