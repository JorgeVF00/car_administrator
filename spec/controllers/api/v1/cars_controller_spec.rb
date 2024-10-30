require 'rails_helper'

RSpec.describe Api::V1::CarsController, type: :controller do
  let(:car) { create(:car) }

  describe 'GET #index' do
    before { get :index, format: :json }

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'renders cars with pagination meta' do
      json_response = JSON.parse(response.body)
      expect(json_response['cars']).to be_an(Array)
      expect(json_response['meta']).to include('current_page', 'total_pages')
    end
  end

  describe 'GET #show' do
    before { get :show, params: { id: car.id }, format: :json }

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'returns the car details' do
      json_response = JSON.parse(response.body)
      expect(json_response['id']).to eq(car.id)
    end
  end

  describe 'POST #create' do
    let(:car_params) { attributes_for(:car) }

    context 'with valid params' do
      it 'creates a new car' do
        expect {
          post :create, params: { car: car_params }, format: :json
        }.to change(Car, :count).by(1)
        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid params' do
      it 'returns unprocessable entity status' do
        post :create, params: { car: { plate_number: nil } }, format: :json
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      it 'updates the car' do
        put :update, params: { id: car.id, car: { model: 'Updated Model' } }, format: :json
        expect(response).to have_http_status(:ok)
        expect(car.reload.model).to eq('Updated Model')
      end
    end

    context 'with invalid params' do
      it 'returns unprocessable entity status' do
        put :update, params: { id: car.id, car: { plate_number: nil } }, format: :json
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'deletes the car' do
      car
      expect {
        delete :destroy, params: { id: car.id }, format: :json
      }.to change(Car, :count).by(-1)
      expect(response).to have_http_status(:no_content)
    end


    it 'returns an error when the car does not exist' do
      expect {
        delete :destroy, params: { id: -1 }, format: :json
      }.to_not change(Car, :count)

      expect(response).to have_http_status(:not_found)
      expect(JSON.parse(response.body)).to include("error" => "Couldn't find Car with 'id'=-1")
    end
  end
end
