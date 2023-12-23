class GeneralShoppingListsController < ApplicationController
  def index
    @recipe_foods = Food.recipe_totals
  end
end
