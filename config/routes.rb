Rails.application.routes.draw do
  get '/sign_out_user', to: 'users#sign_out_user', as: 'sign_out_user'
  devise_for :users
  resources :users
  root 'public_recipes#index'
  resources :foods, only: %i[index show new create destroy]
  resources :general_shopping_lists, only: %i[index]
  resources :public_recipes, only: %i[index show]
  resources :recipes, only: [:index, :show, :new, :create, :destroy, :update] do
    resources :recipe_foods, only: [:new, :create, :destroy, :update,:edit,:show]
  end

  delete '/recipes/:recipe_id/recipe_foods/:id', to: 'recipe_foods#destroy', as: :delete_recipe_food
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end

