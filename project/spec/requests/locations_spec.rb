require 'rails_helper'

RSpec.describe 'Locations API' do
  it "returns locations that belong to a given country based on it's current panel provider" do
    get '/locations/PL'

    expect(response).to be_successful
    expect(json.first.count).equal?(4)
  end

  it "returns empty list if no locations belong to a given country with it's panel provider" do
    get '/locations/UK'

    expect(response).to be_successful
    expect(json.first.count).equal?(0)
  end

  it "returns empty list if country doesn't exist" do
    get '/locations/NOPE'

    expect(response.status).to eq(400)
    expect(json['error']).equal?('Bad parameter')
  end
end
