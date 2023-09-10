require 'rails_helper'

RSpec.describe "Api::V1::Buyers", type: :request do

  describe "GET /index" do
    context 'with correct authorization' do

      let!(:buyers) {create_list(:buyer, 10)}
      
      before do
        get '/api/v1/buyers'
      end 

      it 'returns 200 status' do
        expect(response).to have_http_status(:ok)
      end

      it 'returns correct json response' do
        expect(json['data'].size).to eq(10)
      end
    end
  end

  describe "POST /create" do
    context 'with correct parameters' do

      before do
        post '/api/v1/buyers', params: { buyer: attributes_for(:buyer)}
      end 

      it 'returns 201 status' do
        expect(response).to have_http_status(:created)
      end

      it 'returns correct json response' do
        expect(json['data'].size).to eq(8)
      end

      it 'increase record count' do
        expect(Buyer.count).to eq(1)
      end
    end

    context 'with incorrect parameters' do

      before do
        incorrect_params = {firstname: 'incorrect'}
        post '/api/v1/buyers', params: { buyer: incorrect_params}
      end 

      it 'returns 422 status' do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns correct json response' do
        expect(json['error']).to eq("Failed to create")
      end
    end
  end
  
  describe 'GET /show' do
    context 'with correct parameter' do
      let!(:buyer) { create(:buyer) }

      before do
        get "/api/v1/buyers/#{buyer.id}"
      end

      it 'returns 201 status' do
        expect(response).to have_http_status(:ok)
      end

      it 'returns correct json response' do
        expect(json['data'].size).to eq(8)
      end
    end
  end

  describe "PATCH /update" do
    context 'with correct parameters' do

      let!(:buyer) { create(:buyer) }

      before do
        updated_params = { firstname: 'updated_firstname' }
        patch "/api/v1/buyers/#{buyer.id}", params: { buyer: updated_params}
      end 

      it 'returns 201 status' do
        expect(response).to have_http_status(:ok)
      end

      it 'returns correct json response' do
        expect(json['data'].size).to eq(8)
      end

      it 'updates the record' do
        expect(buyer.reload.firstname).to eq('updated_firstname')
      end
    end
  end

  describe "DELETE /destroy" do
    context 'with correct parameters' do

      let!(:buyer) { create(:buyer) }

      before do
        delete "/api/v1/buyers/#{buyer.id}"
      end 

      it 'returns 204 status' do
        expect(response).to have_http_status(:no_content)
      end

      it 'deletes the record' do
        expect(Buyer.count).to eq(0)
      end
    end
  end

end
