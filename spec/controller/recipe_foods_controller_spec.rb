require 'rails_helper'

RSpec.describe RecipeFoodsController, type: :controller do
  before :each do
    @user = User.create!(name: 'Test User', email: 'test@example.com', password: 'password',
                         password_confirmation: 'password')
    sign_in @user
    @recipe = @user.recipes.create!(name: 'Test Recipe', preparation_time: 30, cooking_time: 45)
    @food = @user.foods.create!(name: 'Test Food', measurement_unit: 'kg', quantity: 1, price: 1)
    @recipe_food = @recipe.recipe_foods.create!(food_name: @food, quantity: 1)
  end

  describe 'GET #new' do
    it 'assigns a new RecipeFood to @recipe_food' do
      get :new, params: { recipe_id: @recipe.id }
      expect(assigns(:recipe_food)).to be_a_new(RecipeFood)
    end
  end

  describe 'POST #create' do
    it 'creates a new RecipeFood' do
      expect do
        post :create, params: { recipe_id: @recipe.id, recipe_food: { food_id: @food.id, quantity: 2 } }
      end.to change(RecipeFood, :count).by(1)
      expect(response).to redirect_to(recipe_path(@recipe))
    end
  end

  describe 'GET #edit' do
    it 'assigns the requested recipe_food to @recipe_food' do
      get :edit, params: { recipe_id: @recipe.id, id: @recipe_food.id }
      expect(assigns(:recipe_food)).to eq(@recipe_food)
    end
  end

  describe 'PATCH #update' do
    it 'updates the requested recipe_food' do
      patch :update, params: { recipe_id: @recipe.id, id: @recipe_food.id, recipe_food: { quantity: 3 } }
      @recipe_food.reload
      expect(@recipe_food.quantity).to eq(3)
      expect(response).to redirect_to(recipe_path(@recipe))
    end
  end

  describe 'DELETE #destroy' do
    it 'deletes the recipe_food' do
      expect do
        delete :destroy, params: { recipe_id: @recipe.id, id: @recipe_food.id }
      end.to change(RecipeFood, :count).by(-1)
      expect(response).to redirect_to(recipe_path(@recipe))
    end
  end
end
