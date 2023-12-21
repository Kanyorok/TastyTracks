class PublicRecipesController < ApplicationController
  def index
    @public_recipes = Recipe.where(public: true).includes(recipe_foods: :food_name)
  end

  def show; end
end
