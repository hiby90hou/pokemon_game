class SpeciesController < ApplicationController
	def index
		@species = Species.all
	end

	def show
		@specie = Species.find_by(identifier:params[:identifier])
		@identify_species = Species.where("identifier LIKE ?", "%#{params[:identifier]}%")
		if params[:fuzzy_search]
			render :json => @identify_species
			return
		end
		render :json => @specie
	end
end
