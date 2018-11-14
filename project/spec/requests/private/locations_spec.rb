require 'rails_helper'

RSpec.describe 'Locations API' do
  let!(:user) { User.create(name: 'User2', password: 'password', email: 'email@mail.com') }
  let(:jwt) { login_user('email@mail.com', 'password') }

  it "returns locations that belong to a given country based on it's current panel provider" do
    get '/private/locations/US', headers: { 'Authorization' => "Bearer #{jwt}" }

    expect(response).to be_successful
    expect(json.count).to equal(7)
  end

  it "returns empty list if no locations belong to a given country with it's panel provider" do
    get '/private/locations/UK', headers: { 'Authorization' => "Bearer #{jwt}" }

    expect(response).to be_successful
    expect(json.count).to equal(0)
  end

  it "returns empty list if country doesn't exist" do
    get '/private/locations/NOPE', headers: { 'Authorization' => "Bearer #{jwt}" }

    expect(response.status).to eq(400)
    expect(json['error']).to eq('Bad parameter')
  end
end
