# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'TournamentsController', type: :request do
  context 'GET #index' do
    it 'should list existing tournaments' do
      tournaments = create_list(:tournament, 3)
      get '/tournaments'
      expect(assigns(:tournaments)).to eq(tournaments)
      expect(assigns(:tournament)).to be_instance_of Tournament
    end
  end

  context 'POST #create' do
    let(:teams) { create_list(:team, 16) }
    let(:team_ids) { teams.pluck(:id) }
    it 'should create new tournament' do
      expect {
        post '/tournaments', params: { tournament: { name: 'Ekstraklasa', team_ids: team_ids } }
      }.to change(Tournament, :count).by 1
      expect(flash[:success]).to match(/Tournament successfully created/)
      expect(response).to redirect_to("/tournaments/#{assigns(:tournament).id}")
    end

    it 'should not create tournament if its name is not unique' do
      tournament = create(:tournament)
      expect {
        post '/tournaments', params: { tournament: { name: tournament.name, team_ids: team_ids } }
      }.to change(Tournament, :count).by 0
      expect(assigns(:tournaments)).to be_present
      expect(response).to render_template(:index)
    end
  end

  context 'GET #show' do
    it 'should show tournament' do
      tournament = create(:tournament)
      get "/tournaments/#{tournament.id}"
      expect(assigns(:tournament)).to eq(tournament)
    end
  end
end
