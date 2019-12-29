 require 'rails_helper'

 RSpec.describe 'Checkin API', type: :request do
   let(:user) { create(:user) }
   let!(:checkins) { create_list(:checkin, 10, user_id: user.id, registrar_id: user.id) }
   let(:checkin_id) { checkins.first.id }
   let(:headers) { valid_headers }

   describe 'GET /checkins' do
     before { get '/checkins', params: {}, headers: headers }

     it 'returns checkins' do
       expect(json).not_to be_empty
       expect(json.size).to eq(10)
     end

     it 'returns status code 200' do
       expect(response).to have_http_status(200)
     end
   end

   describe 'GET /checkins/:id' do
     before { get "/checkins/#{checkin_id}", params: {}, headers: headers }

     context 'when the checkin exists' do
       it 'returns the checkin data' do
         expect(json).not_to be_empty
         expect(json['id']).to eq(checkin_id)
       end

       it 'returns status code 200' do
         expect(response).to have_http_status(200)
       end
     end

     context 'when the there is no record' do
       let(:checkin_id) { 1000 }

       it 'returns a status code 404' do
         expect(response).to have_http_status(404)
       end

       it 'returns not found message' do
         expect(response.body).to match(/Couldn't find Checkin/)
       end
     end
   end


   describe 'POST /checkins' do
     let(:valid_attributes) {{ user_id: user.id, registrar_id: user.id, time: 2.minutes.ago }}

     context 'when the request is valid' do
       before { post '/checkins', params: valid_attributes.to_json, headers: headers }

       it 'creates a checkin record' do
         expect(json['user_id']).to eq(user.id)
       end

       it 'returns status code 201' do
         expect(response).to have_http_status(201)
       end
     end

     context 'when the request is invalid' do
       before { post '/checkins', params: { time: 2.minutes.ago }.to_json, headers: headers }

       it 'returns status code 422' do
         expect(response).to have_http_status(422)
       end

       it 'returns a validation failure message' do
         expect(response.body).to match(/Validation failed:/)
       end
     end
   end

   describe 'PUT /checkins/:id' do
     let(:valid_attributes) {{ time: 3.minutes.ago }}

     context 'when the record exists' do
       before { put "/checkins/#{checkin_id}", params: valid_attributes.to_json, headers: headers }

       it 'updates checkin' do
         expect(response.body).to be_empty
       end

       it 'returns status code 204' do
         expect(response).to have_http_status(204)
       end
     end
   end

   describe 'DELETE /checkins/:id' do
     before { delete "/checkins/#{checkin_id}", params: {}, headers: headers }

     it 'returns status code 204' do 
       expect(response).to have_http_status(204)
     end
   end
 end






