class SpeciesController < ApplicationController
	def index
		@species = Species.all
	end

	def show
		@specie = Species.find_by(identifier:params[:identifier])
		render :json => @specie
	end
end
