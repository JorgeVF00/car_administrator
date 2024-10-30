require 'rails_helper'

RSpec.describe MaintenanceServicesController, type: :controller do
  let(:car) { create(:car) }
  let(:maintenance_service) { create(:maintenance_service, car: car) }

  describe 'GET #index' do
    let!(:car1) { create(:car, plate_number: 'ABC123') }
    let!(:car2) { create(:car, plate_number: 'XYZ789') }
    let!(:pending_service) { create(:maintenance_service, car: car1, status: 'pending') }
    let!(:completed_service) { create(:maintenance_service, car: car2, status: 'completed') }

    context 'without filters' do
      before { get :index }

      it 'returns http success' do
        expect(response).to have_http_status(:success)
      end

      it 'returns all maintenance services' do
        expect(assigns(:maintenance_services)).to match_array([ pending_service, completed_service ])
      end
    end

    context 'with status filter' do
      before { get :index, params: { status: 'pending' } }

      it 'returns only the maintenance services with the specified status' do
        expect(assigns(:maintenance_services)).to contain_exactly(pending_service)
      end
    end

    context 'with plate filter' do
      before { get :index, params: { plate: 'ABC' } }

      it 'returns only the maintenance services with the specified plate' do
        expect(assigns(:maintenance_services)).to contain_exactly(pending_service)
      end
    end

    context 'with both status and plate filters' do
      before { get :index, params: { status: 'completed', plate: 'XYZ' } }

      it 'returns only the maintenance services that match both filters' do
        expect(assigns(:maintenance_services)).to contain_exactly(completed_service)
      end
    end
  end


  describe 'GET #show' do
    before { get :show, params: { id: maintenance_service.id } }

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST #create' do
    let(:valid_params) { attributes_for(:maintenance_service).merge(car_id: car.id) }

    context 'with valid params' do
      it 'creates a new maintenance service and redirects' do
        expect {
          post :create, params: { maintenance_service: valid_params }
        }.to change(MaintenanceService, :count).by(1)
        expect(response).to redirect_to(MaintenanceService.last)
      end
    end

    context 'with invalid params' do
      it 'renders :new with unprocessable entity status' do
        post :create, params: { maintenance_service: { description: nil } }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      it 'updates the maintenance service and redirects' do
        put :update, params: { id: maintenance_service.id, maintenance_service: { status: 'completed' } }
        expect(response).to redirect_to(maintenance_service)
        expect(maintenance_service.reload.status).to eq('completed')
      end
    end

    context 'with invalid params' do
      it 'renders :edit with unprocessable entity status' do
        put :update, params: { id: maintenance_service.id, maintenance_service: { description: nil } }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'deletes the maintenance service and redirects' do
      maintenance_service
      expect {
        delete :destroy, params: { id: maintenance_service.id }
      }.to change(MaintenanceService, :count).by(-1)
      expect(response).to redirect_to(maintenance_services_path)
    end
  end
end
