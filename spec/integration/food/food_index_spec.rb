require 'rails_helper'

RSpec.describe 'Food', type: :system do
  before(:each) do
    RecipeFood.delete_all
    Food.delete_all
    Recipe.delete_all
    User.delete_all
    @user = User.create(name: 'User', surname: 'Spec', email: 'testing@gmail.com', password: 'testing')
    @r1 = Recipe.create(user: @user, name: 'Recipe one', preparation_time: 1, cooking_time: 2,
                        description: 'Recipe one description', public: true)
    @f1 = Food.create(user: @user, name: 'Food item', measurement_unit: 'kg', price: 2, quantity: 5)
  end

  it 'Shows the correct index view' do
    login_user(@user)
    sleep(1)
    visit foods_path
    sleep(1)
    expect(page).to have_content('Add Food Item')
    expect(page).to have_content(@f1.name.to_s)
    expect(page).to have_content(@f1.measurement_unit.to_s)
    expect(page).to have_content('10')
  end

  context 'Food Item Remove action' do
    it 'removes the item' do
      login_user(@user)
      sleep(1)
      visit foods_path
      sleep(1)
      click_button 'REMOVE'
      sleep(1)
      expect(1).not_to have_content(@f1.name)
    end
  end

  context 'Add food item action' do
    it 'redirects to Add new Food view' do
      login_user(@user)
      sleep(1)
      visit foods_path
      sleep(1)
      click_link 'Add Food Item'
      sleep(1)
      expect(current_path).to eq(new_food_path)
    end
  end
end
