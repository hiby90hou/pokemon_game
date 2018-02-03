class CreateSpecies < ActiveRecord::Migration[5.1]
  def change
    create_table :species do |t|
      t.string :identifier
      t.integer :evolves_from_species_id
      t.integer :evolution_chain_id
      t.integer :evolution_min_level
      t.integer :height
      t.integer :weight
      t.string :color
      t.string :shape
      t.integer :species_habitats_relationship_id
      t.integer :capture_rate
      t.string :growth_rate
      t.string :img_url

      t.timestamps
    end
  end
end
