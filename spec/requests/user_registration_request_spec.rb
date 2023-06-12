require 'rails_helper'

RSpec.describe 'User Registration API' do
  describe 'happy path' do
    it 'can create a user', :vcr do
      body = {
        email: 'somethingclever@email.com',
        password: 'biscuits',
        password_confirmation: 'biscuits'
      }.to_json
    
      post '/api/v0/users', params: body, headers: { 'Content-Type' => 'application/json', 'Accept' => 'application/json' }
     
      expect(response).to be_successful
      expect(response.status).to eq(201)
      
      json_response = JSON.parse(@response.body, symbolize_names: true)

      expect(json_response).to be_a(Hash)

      expect(json_response).to have_key(:data)
      expect(json_response[:data]).to be_a(Hash)

      expect(json_response[:data]).to have_key(:id)
      expect(json_response[:data][:id]).to be_a(String)

      expect(json_response[:data]).to have_key(:type)
      expect(json_response[:data][:type]).to eq('user')

      expect(json_response[:data]).to have_key(:attributes)
      expect(json_response[:data][:attributes]).to be_a(Hash)

      expect(json_response[:data][:attributes]).to have_key(:email)
      expect(json_response[:data][:attributes][:email]).to be_a(String)

      expect(json_response[:data][:attributes]).to have_key(:api_key)
      expect(json_response[:data][:attributes][:api_key]).to be_a(String)
    end
  end

  describe 'sad paths' do 
    it 'returns an error if email already exists', :vcr do
      user = User.create!(email: 'somethingclever@email.com', password: 'biscuits', password_confirmation: 'biscuits', api_key: 'jgn983hy48thw9begh98h4539h4')

      body = {
        email: 'somethingclever@email.com',
        password: 'biscuits',
        password_confirmation: 'biscuits'
      }.to_json
    
      post '/api/v0/users', params: body, headers: { 'Content-Type' => 'application/json', 'Accept' => 'application/json' }

      expect(response.status).to eq(422)

      json_response = JSON.parse(response.body, symbolize_names: true)

      expect(json_response).to be_a(Hash)
      expect(json_response).to have_key(:errors)
      expect(json_response[:errors]).to be_a(Array)
      expect(json_response[:errors].first).to eq('Email has already been taken')
    end

    it 'returns an error if passwords do not match', :vcr do
      body = {
        email: 'somethingclever@email.com',
        password: 'biscuitsforever!',
        password_confirmation: 'biscuits'
      }.to_json
    
      post '/api/v0/users', params: body, headers: { 'Content-Type' => 'application/json', 'Accept' => 'application/json' }

      expect(response.status).to eq(422)

      json_response = JSON.parse(response.body, symbolize_names: true)

      expect(json_response).to be_a(Hash)
      expect(json_response).to have_key(:errors)
      expect(json_response[:errors]).to be_a(Array)
      expect(json_response[:errors].first).to eq("Password confirmation doesn't match Password")
    end

    it 'returns an error if email is missing', :vcr do
      body = {
        email: '',
        password: 'biscuits',
        password_confirmation: 'biscuits'
      }.to_json
    
      post '/api/v0/users', params: body, headers: { 'Content-Type' => 'application/json', 'Accept' => 'application/json' }

      expect(response.status).to eq(422)

      json_response = JSON.parse(response.body, symbolize_names: true)

      expect(json_response).to be_a(Hash)
      expect(json_response).to have_key(:errors)
      expect(json_response[:errors]).to be_a(Array)
      expect(json_response[:errors].first).to eq("Email can't be blank")
    end

    it 'returns an error if password is missing', :vcr do
      body = {
        email: 'somethingcelver@email.com',
        password: '',
        password_confirmation: ''
      }.to_json
    
      post '/api/v0/users', params: body, headers: { 'Content-Type' => 'application/json', 'Accept' => 'application/json' }

      expect(response.status).to eq(422)

      json_response = JSON.parse(response.body, symbolize_names: true)

      expect(json_response).to be_a(Hash)
      expect(json_response).to have_key(:errors)
      expect(json_response[:errors]).to be_a(Array)
      expect(json_response[:errors].first).to eq("Password can't be blank")
    end
  end
end