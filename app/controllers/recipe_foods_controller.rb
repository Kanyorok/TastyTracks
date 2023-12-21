class RecipeFoodsController < ApplicationController
    before_action :set_recipe
  
    def new
      @recipe_food = @recipe.recipe_foods.new
    end
  
    def create
      @recipe_food = @recipe.recipe_foods.find_or_initialize_by(food_id: recipe_food_params[:food_id])
      @recipe_food.quantity = recipe_food_params[:quantity] # Set quantity
      @recipe_food.calculate_value
      if @recipe_food.save
        redirect_to @recipe, notice: 'Food added successfully.'
      else
        render :new
      end
    end
end