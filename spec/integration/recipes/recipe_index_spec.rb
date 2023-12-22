require 'rails_helper'

RSpec.describe 'Recipe', type: :system do
  before :each do
    RecipeFood.delete_all
    Food.delete_all
    Recipe.delete_all
    User.delete_all
    @user = User.create(name: 'User', surname: 'Spec', email: 'testing@gmail.com', password: 'testing')
    @r1 = Recipe.create(user: @user, name: 'Recipe one', preparation_time: 1, cooking_time: 2,
                        description: 'Recipe one description', public: true)
    @r2 = Recipe.create(user: @user, name: 'Recipe two', preparation_time: 2, cooking_time: 3,
                        description: 'Recipe two description', public: false)
    @r3 = Recipe.create(user: @user, name: 'Recipe three', preparation_time: 1, cooking_time: 1,
                        description: 'Recipe three description', public: true)
  end

  context 'user logs in successfully' do
    it 'should redirect to the root path and display user recipes' do
      login_user(@user)
      expect(current_path).to eq(root_path)
      expect(page).to have_content('Signed in successfully.')

      expect(page).to have_content('My Recipes')
      sleep(1)
      click_link @r1.name
      sleep(1)
      expect(current_path).to eq public_recipe_path(@r1)
      visit root_path
      sleep(1)
      click_link @r3.name
      sleep(1)
      expect(current_path).to eq public_recipe_path(@r3)
    end
  end

  context '#index' do
    it 'should direct to recipes index' do
      login_user(@user)
      sleep(1)
      visit recipes_path
      sleep(1)
      expect(current_path).to eq(recipes_path)
    end
  end
end
