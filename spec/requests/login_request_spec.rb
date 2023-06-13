require 'rails_helper'

RSpec.describe 'Login API' do
  describe 'happy path' do
    it 'can login a user',  vcr: { record: :new_episodes } do
      user = User.create!(email: 'somethingclever@email.com', password: 'biscuits', password_confirmation: 'biscuits', api_key: 'jgn983hy48thw9begh98h4539h4')

      body = {
        email: 'somethingclever@email.com',
        password: 'biscuits'
      }.to_json

      post '/api/v0/sessions', params: body, headers: { 'Content-Type' => 'application/json', 'Accept' => 'application/json' }

      expect(response).to be_successful
      expect(response.status).to eq(200)

      json_response = JSON.parse(response.body, symbolize_names: true)

      expect(json_response).to have_key(:data)
      expect(json_response[:data]).to have_key(:id)

      expect(json_response[:data]).to have_key(:type)
      expect(json_response[:data][:type]).to eq('user')

      expect(json_response[:data]).to have_key(:attributes)
      expect(json_response[:data][:attributes]).to have_key(:email)
      expect(json_response[:data][:attributes][:email]).to eq(user.email)
      expect(json_response[:data][:attributes]).to have_key(:api_key)
      expect(json_response[:data][:attributes][:api_key]).to eq('jgn983hy48thw9begh98h4539h4')
    end
  end

  describe 'sad paths' do
    it 'returns an error if email is incorrect',  vcr: { record: :new_episodes } do
      user = User.create!(email: 'somethingclever@email.com', password: 'biscuits', password_confirmation: 'biscuits', api_key: 'jgn983hy48thw9begh98h4539h4')

      body = {
        email: 'somethingoneclever@email.com',
        password: 'biscuits'
      }.to_json

      post '/api/v0/sessions', params: body, headers: { 'Content-Type' => 'application/json', 'Accept' => 'application/json' }

      expect(response.status).to eq(401)
      
      json_response = JSON.parse(response.body, symbolize_names: true)

      expect(json_response).to be_a(Hash)
      expect(json_response).to have_key(:errors)
      expect(json_response[:errors]).to eq('Bad Credentials')
    end

    it 'returns an error if password is incorrect',  vcr: { record: :new_episodes } do
      user = User.create!(email: 'somethingclever@email.com', password: 'biscuits', password_confirmation: 'biscuits', api_key: 'jgn983hy48thw9begh98h4539h4')

      body = {
        email: 'somethingclever@email.com',
        password: 'i-hate-biscuits'
      }.to_json

      post '/api/v0/sessions', params: body, headers: { 'Content-Type' => 'application/json', 'Accept' => 'application/json' }

      expect(response.status).to eq(401)
      
      json_response = JSON.parse(response.body, symbolize_names: true)

      expect(json_response).to be_a(Hash)
      expect(json_response).to have_key(:errors)
      expect(json_response[:errors]).to eq('Bad Credentials')
    end

    it 'returns an error if email is missing',  vcr: { record: :new_episodes } do
      user = User.create!(email: 'somethingclever@email.com', password: 'biscuits', password_confirmation: 'biscuits', api_key: 'jgn983hy48thw9begh98h4539h4')

      body = {
        email: '',
        password: 'i-hate-biscuits'
      }.to_json

      post '/api/v0/sessions', params: body, headers: { 'Content-Type' => 'application/json', 'Accept' => 'application/json' }

      expect(response.status).to eq(401)
      
      json_response = JSON.parse(response.body, symbolize_names: true)

      expect(json_response).to be_a(Hash)
      expect(json_response).to have_key(:errors)
      expect(json_response[:errors]).to eq('Bad Credentials')
    end

    it 'returns an error if password is missing',  vcr: { record: :new_episodes } do
      user = User.create!(email: 'somethingclever@email.com', password: 'biscuits', password_confirmation: 'biscuits', api_key: 'jgn983hy48thw9begh98h4539h4')
      
      body = {
        email: 'somethingclever@email.com',
        password: ''
      }.to_json

      post '/api/v0/sessions', params: body, headers: { 'Content-Type' => 'application/json', 'Accept' => 'application/json' }

      expect(response.status).to eq(401)
      
      json_response = JSON.parse(response.body, symbolize_names: true)

      expect(json_response).to be_a(Hash)
      expect(json_response).to have_key(:errors)
      expect(json_response[:errors]).to eq('Bad Credentials')
    end

    it 'returns an error if the user does not exist',  vcr: { record: :new_episodes } do
      body = {
        email: 'somethingoneclever@email.com',
        password: 'biscuits'
      }.to_json

      post '/api/v0/sessions', params: body, headers: { 'Content-Type' => 'application/json', 'Accept' => 'application/json' }

      expect(response.status).to eq(401)
      
      json_response = JSON.parse(response.body, symbolize_names: true)

      expect(json_response).to be_a(Hash)
      expect(json_response).to have_key(:errors)
      expect(json_response[:errors]).to eq('Bad Credentials')
    end
  end
end