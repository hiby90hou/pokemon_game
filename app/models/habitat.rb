class Habitat < ApplicationRecord
	has_many :species_habitats_relationships
	has_many :species, through: :species_habitats_relationships
end
