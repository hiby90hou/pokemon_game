Rails.application.routes.draw do
  resources :my_pokemons
  resources :experiences, only: [:index]
  resources :species, only: [:index,:show]
  resources :habitats, only: [:index]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
