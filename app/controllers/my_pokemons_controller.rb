class MyPokemonsController < ApplicationController
	def index
		@pokemons = MyPokemon.all

		@pokemons.each{|pokemon|

			exp_standard = Experience.where(growth_rate:pokemon.growth_rate
)

			#check each pokmon's time difference between current time and update time
			time_difference = Time.now.utc - pokemon.updated_at

			#add exp base on time pass
			pokemon.exp = pokemon.exp + time_difference #1 min get 1 exp

			#if exp > upgrate request exp, upgrate to next level
			while pokemon.exp > exp_standard.find_by(level:pokemon.level).experience.to_i
				pokemon.exp = pokemon.exp - exp_standard.find_by(level:pokemon.level).experience.to_i
				pokemon.level += 1
			end

			# update exp, level & update_at to current time
			updatePokemon = MyPokemon.find_by(id:pokemon.id)
			updatePokemon.exp = pokemon.exp
			updatePokemon.level = pokemon.level
			updatePokemon.save
		}

	end

	def new
	end

	def create
		identifier = params[:identifier].chomp.to_s
		pokemon = Species.find_by(identifier:identifier)

		# render :json => @pokemon
		if pokemon
			new_pokemon = MyPokemon.new
			new_pokemon.species_id = pokemon.id
			new_pokemon.nickname = params[:nickname]
			new_pokemon.level = params[:level]
			new_pokemon.exp = 0
			new_pokemon.growth_rate = pokemon.growth_rate
			new_pokemon.save

			redirect_to '/my_pokemons'
		else
			redirect_to '/'
		end
	end
end
