require 'rails_helper'

RSpec.describe CarsController, type: :controller do
  let(:car) { create(:car) }

  describe 'GET #index' do
    before { get :index }

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #show' do
    before { get :show, params: { id: car.id } }

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST #create' do
    let(:car_params) { attributes_for(:car) }

    context 'with valid params' do
      it 'creates a new car' do
        expect {
          post :create, params: { car: car_params }
        }.to change(Car, :count).by(1)
        expect(response).to redirect_to(Car.last)
      end
    end

    context 'with invalid params' do
      it 'renders :new with unprocessable entity status' do
        post :create, params: { car: { plate_number: nil } }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      it 'updates the car and redirects' do
        put :update, params: { id: car.id, car: { model: 'Updated Model' } }
        expect(response).to redirect_to(car)
        expect(car.reload.model).to eq('Updated Model')
      end
    end

    context 'with invalid params' do
      it 'renders :edit with unprocessable entity status' do
        put :update, params: { id: car.id, car: { plate_number: nil } }, format: :html
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'deletes the car and redirects' do
      car
      expect {
        delete :destroy, params: { id: car.id }
      }.to change(Car, :count).by(-1)
      expect(response).to redirect_to(cars_path)
    end
  end
end
