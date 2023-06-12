require 'rails_helper'

RSpec.describe 'Book Search API' do
  describe 'happy path' do
    it 'can search for books by city', :vcr do
      get '/api/v0/book-search?location=denver,co&quantity=5'

      expect(response).to be_successful
      expect(response.status).to eq(200)

      json_response = JSON.parse(response.body, symbolize_names: true)

      expect(json_response).to be_a(Hash)
      expect(json_response).to have_key(:data)
      expect(json_response[:data]).to be_a(Hash)
      expect(json_response[:data]).to have_key(:id)
      expect(json_response[:data][:id]).to eq(nil)
      expect(json_response[:data]).to have_key(:type)
      expect(json_response[:data][:type]).to eq('books')
    
      expect(json_response[:data][:attributes]).to be_a(Hash)
      expect(json_response[:data][:attributes][:destination]).to be_a(String)
      expect(json_response[:data][:attributes][:destination]).to eq('denver,co')

      expect(json_response[:data][:attributes][:forecast]).to be_a(Hash)
      expect(json_response[:data][:attributes][:forecast][:summary]).to be_a(String)
      expect(json_response[:data][:attributes][:forecast][:temperature]).to be_a(String)

      expect(json_response[:data][:attributes][:total_books_found]).to be_a(Integer)

      expect(json_response[:data][:attributes][:books]).to be_an(Array)
      expect(json_response[:data][:attributes][:books].count).to eq(5)

      expect(json_response[:data][:attributes][:books][0]).to be_a(Hash)
      expect(json_response[:data][:attributes][:books][0][:isbn]).to be_a(Array)
      expect(json_response[:data][:attributes][:books][0][:title]).to be_a(String)
      expect(json_response[:data][:attributes][:books][0][:publisher]).to be_a(Array)
    end
  end
    

  describe 'sad path' do
    it 'returns an error if no city is provided', :vcr do
      get '/api/v0/book-search?quantity=5'

      expect(response).to_not be_successful
      expect(response.status).to eq(400)
      
      json_response = JSON.parse(response.body, symbolize_names: true)

      expect(json_response).to be_a(Hash)
      expect(json_response).to have_key(:errors)
      expect(json_response[:errors]).to eq('Must Provide a Location')
    end

    it 'returns an error if a negitive quantity is provided', :vcr do
      get '/api/v0/book-search?location=denver,co&quantity=-5'

      expect(response).to_not be_successful
      expect(response.status).to eq(400)
      
      json_response = JSON.parse(response.body, symbolize_names: true)

      expect(json_response).to be_a(Hash)
      expect(json_response).to have_key(:errors)
      expect(json_response[:errors]).to eq('Must Provide a Quantity Greater Than 0')
    end

    it 'returns an error if a quantity of 0 is provided', :vcr do
      get '/api/v0/book-search?location=denver,co&quantity=0'

      expect(response).to_not be_successful
      expect(response.status).to eq(400)
      
      json_response = JSON.parse(response.body, symbolize_names: true)

      expect(json_response).to be_a(Hash)
      expect(json_response).to have_key(:errors)
      expect(json_response[:errors]).to eq('Must Provide a Quantity Greater Than 0')
    end

    it 'returns an error if no quantity is provided', :vcr do
      get '/api/v0/book-search?location=denver,co'

      expect(response).to_not be_successful
      expect(response.status).to eq(400)
      
      json_response = JSON.parse(response.body, symbolize_names: true)

      expect(json_response).to be_a(Hash)
      expect(json_response).to have_key(:errors)
      expect(json_response[:errors]).to eq('Must Provide a Quantity Greater Than 0')
    end
  end
end


