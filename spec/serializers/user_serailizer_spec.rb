require 'rails_helper'

RSpec.describe UserSerializer do
  it 'can serialize a user' do 
    user = User.create!(email: 'somethingcool@gmail.com' , password: 'password', password_confirmation: 'password', api_key: 'jgn983hy48thw9begh98h4539h4')

    serialized_user = UserSerializer.new(user)
    json = JSON.parse(serialized_user.to_json, symbolize_names: true)
    
    expect(json).to be_a(Hash)
    expect(json).to have_key(:data)
    expect(json[:data]).to be_a(Hash)

    expect(json[:data]).to have_key(:id)
    expect(json[:data][:id]).to eq(user.id.to_s)

    expect(json[:data]).to have_key(:type)
    expect(json[:data][:type]).to eq('user')

    expect(json[:data]).to have_key(:attributes)
    expect(json[:data][:attributes]).to be_a(Hash)

    expect(json[:data][:attributes]).to have_key(:email)
    expect(json[:data][:attributes][:email]).to eq(user.email)

    expect(json[:data][:attributes]).to have_key(:api_key)
    expect(json[:data][:attributes][:api_key]).to eq(user.api_key)

    expect(json[:data][:attributes]).to_not have_key(:password)
    expect(json[:data][:attributes]).to_not have_key(:password_confirmation)
    expect(json[:data][:attributes]).to_not have_key(:password_digest)
  end
end