require 'rails_helper'

RSpec.describe FoodsController, type: :controller do
  before :each do
    @user = User.create!(name: 'Test User', email: 'test@example.com', password: 'password', password_confirmation: 'password')
    sign_in @user
    @food = @user.foods.create!(name: 'Test Food', measurement_unit: 'kg', quantity: 1, price: 1)
  end

  describe 'GET #index' do
    it 'assigns all foods to @foods' do
      get :index
      expect(assigns(:foods)).to eq([@food])
    end
  end

  describe 'GET #show' do
    it 'assigns the requested food to @food' do
      get :show, params: { id: @food.id }
      expect(assigns(:food)).to eq(@food)
    end
  end

  describe 'GET #new' do
    it 'assigns a new Food to @food' do
      get :new
      expect(assigns(:food)).to be_a_new(Food)
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'creates a new food' do
        expect {
          post :create, params: { food: { name: 'New Food', measurement_unit: 'kg', quantity: 1, price: 1 } }
        }.to change(Food, :count).by(1)
      end
    end

    context 'with invalid attributes' do
      it 'does not save the new food' do
        expect {
          post :create, params: { food: { name: '', measurement_unit: '', quantity: '', price: '' } }
        }.to_not change(Food, :count)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'deletes the food' do
      expect {
        delete :destroy, params: { id: @food.id }
      }.to change(Food, :count).by(-1)
    end
  end
end