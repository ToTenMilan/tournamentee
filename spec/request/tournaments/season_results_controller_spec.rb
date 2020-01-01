# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Tournaments::SeasonResultsController, type: :request do
  context 'PATCH #update' do
    let(:tournament) { create(:tournament_with_games) }
    it 'should update and return tournament' do
      # pending "SeasonResultsGenerator not implemented"
      patch "/tournaments/season_results/#{tournament.id}"
      expect(assigns(:tournament)).to be_present
      expect(flash[:success]).to match(/Season results successfully generated/)
    end

    # it 'should not update tournament if its name is not unique' do
    #   tournament = create(:tournament)
    #   expect {
    #     post '/tournaments', params: { tournament: { name: tournament.name, team_ids: team_ids } }
    #   }.to change(Tournament, :count).by 0
    # end
  end
end
