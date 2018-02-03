class CreateHabitats < ActiveRecord::Migration[5.1]
  def change
    create_table :habitats do |t|
      t.string :identifier
      t.integer :rarity

      t.timestamps
    end
  end
end
