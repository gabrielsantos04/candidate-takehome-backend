require 'rails_helper'

RSpec.describe RegistryHostsController, type: :controller do
  let!(:registry_host) { create(:registry_host) }
  let!(:confidential_registry_host) { create(:registry_host, :confidential) }

  describe 'POST #create' do
    let(:source) { 'http://example.com' }
    let(:params) do
      {
        registry_host: {
          source: source,
          destination: 'http://example.com',
          status: 'active',
          confidential: false
        }
      }
    end

    context 'when has valid params' do
      it 'should create a registry host' do
        post :create, params: params
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when has invalid params' do
      let(:source) { nil }
      it 'should not create a registry host' do
        post :create, params: params
        expect(response).to have_http_status(:bad_request)
        expect(JSON.parse(response.body)['error']).to eq('Registry host not created')
      end
    end
  end

  describe 'GET #list_all' do
    let(:expected_response) do
      [
        {
          'id' => registry_host.id,
          'source' => registry_host.source,
          'destination' => registry_host.destination,
          'status' => registry_host.status,
          'confidential' => registry_host.confidential,
          'created_at' => registry_host.created_at.to_s,
          'updated_at' => registry_host.updated_at.to_s
        },
        {
          'id' => confidential_registry_host.id,
          'source' => confidential_registry_host.source,
          'destination' => '-',
          'status' => '-',
          'confidential' => confidential_registry_host.confidential,
          'created_at' => confidential_registry_host.created_at.to_s,
          'updated_at' => '-'
        }
      ]
    end

    it 'should list all registry hosts' do
      get :list_all
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)).to eq(expected_response)
    end
  end

  describe 'GET #search' do
    let!(:registry_hosts) { create_list(:registry_host, 3, source: "searchexample.com") }

    context 'when has no filter' do
      it 'should return an error' do
        get :search
        expect(response).to have_http_status(:bad_request)
        expect(JSON.parse(response.body)['error']).to eq('Filter parameter is required')
      end
    end

    context 'when has filter' do
      it 'should return all registry hosts that matchs' do
        get :search, params: { filter: "searchexample" }
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body).size).to eq(3)
      end
    end
  end

  describe 'GET #show' do
    let(:registry_host) { create(:registry_host) }

    context 'when has a valid id' do
      it 'should show a registry host' do
        get :show, params: { id: registry_host.id }
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)['id']).to eq(registry_host.id)
      end
    end

    context 'when has a invalid id' do
      it 'should not show a registry host' do
        get :show, params: { id: 0 }
        expect(response).to have_http_status(:not_found)
        expect(JSON.parse(response.body)['error']).to eq('Registry host not found')
      end
    end
  end

  describe 'POST #update_status' do
    let(:registry_host) { create(:registry_host, status: 'active') }

    it 'should update status of a registry host' do
      post :update_status, params: { id: registry_host.id, status: 'inactive' }
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['status']).to eq('inactive')
      expect(registry_host.reload.status).to eq('inactive')
    end
  end
end
