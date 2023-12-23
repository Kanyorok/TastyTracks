require 'rails_helper'

RSpec.describe RecipesController, type: :controller do
  before :each do
    @user = User.create!(name: 'Test User', email: 'test@example.com', password: 'password',
                         password_confirmation: 'password')
    sign_in @user
    @recipe = @user.recipes.create!(name: 'Test Recipe', description: 'Test Description', cooking_time: 1,
                                    preparation_time: 1, public: true)
  end

  describe 'GET #index' do
    it 'assigns all recipes to @recipes' do
      get :index
      expect(assigns(:recipes)).to eq([@recipe])
    end
  end

  describe 'GET #show' do
    it 'assigns the requested recipe to @recipe' do
      get :show, params: { id: @recipe.id }
      expect(assigns(:recipe)).to eq(@recipe)
    end
  end

  describe 'GET #new' do
    it 'assigns a new Recipe to @recipe' do
      get :new
      expect(assigns(:recipe)).to be_a_new(Recipe)
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'creates a new recipe' do
        expect do
          post :create,
               params: { recipe: { name: 'New Recipe', description: 'New Description',
                                   cooking_time: 1, preparation_time: 1, public: true } }
        end.to change(Recipe, :count).by(1)
      end
    end

    context 'with invalid attributes' do
      it 'does not save the new recipe' do
        expect do
          post :create,
               params: { recipe: { name: '', description: '', cooking_time: '', preparation_time: '', public: '' } }
        end.to_not change(Recipe, :count)
      end
    end
  end

  describe 'GET #edit' do
    it 'assigns the requested recipe to @recipe' do
      recipe = Recipe.new(name: 'Test Recipe', description: 'Test Description', cooking_time: 1,
                          preparation_time: 1, public: true, user: @user)
      recipe.save
      get :edit, params: { id: recipe.id }
      expect(assigns(:recipe)).to eq(recipe)
    end
  end

  describe 'PATCH #update' do
    context 'with valid attributes' do
      it 'updates the recipe' do
        patch :update, params: { id: @recipe.id, recipe: { name: 'Updated Recipe' } }
        @recipe.reload
        expect(@recipe.name).to eq('Updated Recipe')
      end
    end

    context 'with invalid attributes' do
      it 'does not update the recipe' do
        patch :update, params: { id: @recipe.id, recipe: { name: '' } }
        @recipe.reload
        expect(@recipe.name).to_not eq('')
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'deletes the recipe' do
      expect do
        delete :destroy, params: { id: @recipe.id }
      end.to change(Recipe, :count).by(-1)
    end
  end
end
