# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


require 'csv'

csv = CSV.foreach("raw_data/experiences.csv")

csv.each do |row|
	Experience.create(growth_rate: row[1], level: row[2], experience: row[3])
end

csv = CSV.foreach("raw_data/habitats.csv")

csv.each do |row|
	Habitat.create(identifier: row[1], rarity: row[2])
end

csv = CSV.foreach("raw_data/species.csv")

csv.each do |row|
	Species.create(identifier: row[1], evolves_from_species_id: row[2],evolution_chain_id: row[3],evolution_min_level: row[4], height:row[5], weight:row[6], color:row[7],shape:row[8],species_habitats_relationship_id:row[9], capture_rate:row[10], growth_rate:row[11],img_url:row[12])
end

csv = CSV.foreach("raw_data/species_habitats_relationship.csv")

csv.each do |row|
	SpeciesHabitatsRelationship.create(species_id: row[1], habitat_id: row[2])
end


