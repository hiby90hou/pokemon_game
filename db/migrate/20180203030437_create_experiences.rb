class CreateExperiences < ActiveRecord::Migration[5.1]
  def change
    create_table :experiences do |t|
      t.string :growth_rate
      t.integer :level
      t.integer :experience

      t.timestamps
    end
  end
end
