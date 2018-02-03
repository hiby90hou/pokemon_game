class CreateSpeciesHabitatsRelationships < ActiveRecord::Migration[5.1]
  def change
    create_table :species_habitats_relationships do |t|
      t.references :species, foreign_key: true
      t.references :habitat, foreign_key: true

      t.timestamps
    end
  end
end
