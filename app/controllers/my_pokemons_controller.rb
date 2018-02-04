class MyPokemonsController < ApplicationController
	skip_before_action :verify_authenticity_token
	def index
		@pokemons = MyPokemon.all

		@pokemons.each{|pokemon|

			exp_standard = Experience.where(growth_rate:pokemon.growth_rate)

			#check each pokmon's time difference between current time and update time
			time_difference = Time.now.utc - pokemon.updated_at

			#add exp base on time pass
			pokemon.exp = pokemon.exp + time_difference*10000 #1 min get 1 exp

			#if exp > upgrate request exp, upgrate to next level
			while pokemon.level < 100 && pokemon.exp > exp_standard.find_by(level:pokemon.level).experience.to_i
				pokemon.exp = pokemon.exp - exp_standard.find_by(level:pokemon.level).experience.to_i
				pokemon.level += 1
				pokemon.ready_for_evolution = false

				# if pokemon can evolute, ture the ready_for_evolution on
				evolute_species = Species.find_by(evolves_from_species_id: pokemon.species_id)
				if evolute_species != nil
					if evolute_species.evolution_min_level == nil || pokemon.level > evolute_species.evolution_min_level
						pokemon.ready_for_evolution = true
					end
				end
			end

			# case of pokemon level wore than 100
			if pokemon.level >= 100
				pokemon.level = 100
				pokemon.exp = 0
			end

			# update exp, level & update_at to current time
			updatePokemon = MyPokemon.find_by(id:pokemon.id)
			updatePokemon.exp = pokemon.exp
			updatePokemon.level = pokemon.level
			updatePokemon.ready_for_evolution = pokemon.ready_for_evolution
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

	# evolute
	def update
		@pokemon = MyPokemon.find_by(id:params[:id])
		evolutePokemon = Species.find_by(evolves_from_species_id: @pokemon.species_id)
		@pokemon.species_id = evolutePokemon.id
		@pokemon.ready_for_evolution = false

		# if pokemon can evolute, ture the ready_for_evolution on
		evolute_species = Species.find_by(evolves_from_species_id: @pokemon.species_id)
		if evolute_species != nil
			if evolute_species.evolution_min_level == nil || @pokemon.level > evolute_species.evolution_min_level
				@pokemon.ready_for_evolution = true
			end
		end

		@pokemon.save

		# @pokemon.species_name = Species.find_by(id:@pokemon.species_id).identifier
		newSpecies = Species.find_by(id:@pokemon.species_id)
		@result = {
			"species_name": newSpecies.identifier,
			"img_url": newSpecies.img_url,
			"ready_for_evolution": @pokemon.ready_for_evolution
		}
		render :json => @result
	end
end
