class CreateMyPokemons < ActiveRecord::Migration[5.1]
  def change
    create_table :my_pokemons do |t|
      t.references :species, foreign_key: true
      t.string :nickname
      t.integer :level
      t.integer :exp
      t.string :growth_rate

      t.timestamps
    end
  end
end
