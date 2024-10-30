require 'rails_helper'

RSpec.describe Api::V1::MaintenanceServicesController, type: :controller do
  let(:car) { create(:car) }
  let(:maintenance_service) { create(:maintenance_service, car: car) }

  describe 'GET #index' do
    before { get :index, format: :json }

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'renders maintenance services with pagination meta' do
      json_response = JSON.parse(response.body)
      expect(json_response['maintenance_services']).to be_an(Array)
      expect(json_response['meta']).to include('current_page', 'total_pages')
    end
  end

  describe 'GET #show' do
    before { get :show, params: { id: maintenance_service.id }, format: :json }

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'returns the maintenance service details' do
      json_response = JSON.parse(response.body)
      expect(json_response['id']).to eq(maintenance_service.id)
    end
  end

  describe 'POST #create' do
    let(:valid_params) { attributes_for(:maintenance_service).merge(car_id: car.id) }

    context 'with valid params' do
      it 'creates a new maintenance service' do
        expect {
          post :create, params: { maintenance_service: valid_params }, format: :json
        }.to change(MaintenanceService, :count).by(1)
        expect(response).to have_http_status(:created)
      end
    end

    context 'with invalid params' do
      it 'returns unprocessable entity status' do
        post :create, params: { maintenance_service: { description: nil } }, format: :json
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      it 'updates the maintenance service' do
        put :update, params: { id: maintenance_service.id, maintenance_service: { status: 'completed' } }, format: :json
        expect(response).to have_http_status(:ok)
        expect(maintenance_service.reload.status).to eq('completed')
      end
    end

    context 'with invalid params' do
      it 'returns unprocessable entity status' do
        put :update, params: { id: maintenance_service.id, maintenance_service: { description: nil } }, format: :json
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'deletes the maintenance service' do
      maintenance_service
      expect {
        delete :destroy, params: { id: maintenance_service.id }, format: :json
      }.to change(MaintenanceService, :count).by(-1)
      expect(response).to have_http_status(:no_content)
    end

    it 'returns an error when the maintenance service does not exist' do
      expect {
        delete :destroy, params: { id: -1 }, format: :json
      }.to_not change(MaintenanceService, :count)

      expect(response).to have_http_status(:not_found)
      expect(JSON.parse(response.body)).to include("error" => "Couldn't find MaintenanceService with 'id'=-1")
    end
  end
end
