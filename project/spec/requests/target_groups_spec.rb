require 'rails_helper'

RSpec.describe 'Target groups API' do
  describe 'GET /target_groups/:country_code' do
    it "returns target groups that belong to a given country based on it's current panel provider" do
      get '/target_groups/PL'

      expect(response).to be_successful
      expect(json.count).to equal(10)
    end

    it "returns empty list if no target groups belong to a given country with it's panel provider" do
      get '/target_groups/UK'

      expect(response).to be_successful
      expect(json.count).to equal(0)
    end

    it "returns an error if country doesn't exist" do
      get '/target_groups/NOPE'

      expect(response.status).to equal(400)
      expect(json['error']).to eq('Bad parameter')
    end
  end
end
