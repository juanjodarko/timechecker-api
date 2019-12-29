require 'rails_helper'

RSpec.describe 'Checkout API', type: :request do
  let(:user) { create(:user) }
  let!(:checkouts) { create_list(:checkout, 10, user_id: user.id, registrar_id: user.id) }
  let(:checkout_id) { checkouts.first.id }
  let(:headers) { valid_headers }

  describe 'GET /checkouts' do
    before { get '/checkouts', params: {}, headers: headers }

    it 'returns checkouts' do
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end


  describe 'GET /checkouts/:id' do
    before { get "/checkouts/#{checkout_id}", params: {}, headers: headers }

    context 'when the checkout exists' do
      it 'returns the checkout data' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(checkout_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when there is no record' do
      let(:checkout_id) { 1000 }

      it 'returns a status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns not found message' do
        expect(response.body).to match(/Couldn't find Checkout/)
      end
    end
  end

  describe 'POST /checkouts' do
    let(:valid_attributes) {{ user_id: user.id, registrar_id: user.id, time: 1.minute.ago }}

    context 'when the request is valid' do
      before { post '/checkouts', params: valid_attributes.to_json, headers: headers }

      it 'creates a checkout record' do
        expect(json['user_id']).to eq(user.id)
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/checkouts', params: {time: 2.minutes.ago }.to_json, headers: headers }
      
      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body).to match(/Validation failed:/)
      end
    end
  end

  describe 'PUT /checkouts/:id' do
    let(:valid_attributes) {{ time: 2.minutes.ago }}

    context 'when the record exists' do
      before { put "/checkouts/#{checkout_id}", params: valid_attributes.to_json, headers: headers }

      it 'updates checkout' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  describe 'DELETE /checkouts/:id' do
    before { delete "/checkouts/#{checkout_id}", params: {}, headers: headers }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end


end
