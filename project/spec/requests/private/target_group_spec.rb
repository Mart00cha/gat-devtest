require 'rails_helper'

RSpec.describe 'Target groups private API' do
  let!(:user) { User.create(name: 'User1', password: 'password', email: 'mail@mail.com') }
  let(:jwt) { login_user('mail@mail.com', 'password') }

  describe 'GET /target_groups/:country_code' do
    it "returns target groups that belong to a given country based on it's current panel provider" do
      get '/private/target_groups/PL', headers: { 'Authorization' => "Bearer #{jwt}" }

      expect(response).to be_successful
      expect(json.count).to equal(10)
    end

    it "returns empty list if no target groups belong to a given country with it's panel provider" do
      get '/private/target_groups/UK', headers: { 'Authorization' => "Bearer #{jwt}" }

      expect(response).to be_successful
      expect(json.count).to equal(0)
    end

    it "returns an error if country doesn't exist" do
      get '/private/target_groups/NOPE', headers: { 'Authorization' => "Bearer #{jwt}" }

      expect(response.status).to equal(400)
      expect(json['error']).to eq('Bad parameter')
    end
  end

  describe 'POST /evaluate_target' do
    let(:params) do
      { country_code: 'PL',
        target_group_id: TargetGroup.first.external_id,
        locations: [{ id: Location.first.external_id, panel_size: 200 },
                    { id: Location.last.external_id, panel_size: 100 }] }
    end

    it 'returns evaluation for correct params' do
      post '/private/evaluate_target',
           headers: { 'Authorization' => "Bearer #{jwt}" },
           params: params

      expect(response).to be_successful
    end

    it 'returns an error if country_code missing' do
      post '/private/evaluate_target',
           headers: { 'Authorization' => "Bearer #{jwt}" },
           params: params.except(:country_code)
      expect(response.status).to equal(400)
      expect(json['error']).to eq('Bad parameter')
    end

    it 'returns an error if target_group_id missing' do
      post '/private/evaluate_target',
           headers: { 'Authorization' => "Bearer #{jwt}" },
           params: params.except(:target_group_id)
      expect(response.status).to equal(400)
      expect(json['error']).to eq('Bad parameter')
    end

    it 'returns an error if locations missing' do
      post '/private/evaluate_target',
           headers: { 'Authorization' => "Bearer #{jwt}" },
           params: params.except(:locations)
      expect(response.status).to equal(400)
      expect(json['error']).to eq('Bad parameter')
    end

    it 'returns an error if country does not exist' do
      params[:country_code] = 'non_existent'
      post '/private/evaluate_target',
           headers: { 'Authorization' => "Bearer #{jwt}" },
           params: params
      expect(response.status).to equal(400)
      expect(json['error']).to eq('Bad parameter')
    end

    it 'returns an error if target group does not exist' do
      params[:target_group_id] = 'non_existent'
      post '/private/evaluate_target',
           headers: { 'Authorization' => "Bearer #{jwt}" },
           params: params
      expect(response.status).to equal(400)
      expect(json['error']).to eq('Bad parameter')
    end

    it 'returns an error if location does not exist' do
      params[:locations].first[:id] = 'KK'
      post '/private/evaluate_target',
           headers: { 'Authorization' => "Bearer #{jwt}" },
           params: params
      expect(response.status).to equal(400)
      expect(json['error']).to eq('Bad parameter')
    end

    it 'returns an error if location missing panel size' do
      params[:locations].first[:id] = nil
      post '/private/evaluate_target',
           headers: { 'Authorization' => "Bearer #{jwt}" },
           params: params
      expect(response.status).to equal(400)
      expect(json['error']).to eq('Bad parameter')
    end
  end
end
