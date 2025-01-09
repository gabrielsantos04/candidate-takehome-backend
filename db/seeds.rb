# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

file = File.read("db/seed_registry.json")
data = JSON.parse(file)

data.each do |registry|
  RegistryHost.create(
    source: registry["source"],
    destination: registry["destination"],
    status: registry["status"],
    confidential: registry["confidential"],
  )
end
