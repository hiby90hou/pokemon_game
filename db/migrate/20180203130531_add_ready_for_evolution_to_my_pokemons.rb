class AddReadyForEvolutionToMyPokemons < ActiveRecord::Migration[5.1]
  def change
    add_column :my_pokemons, :ready_for_evolution, :boolean
  end
end
