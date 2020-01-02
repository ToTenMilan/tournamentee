# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Tournaments::SeasonResultsController, type: :request do
  context 'PATCH #update' do
    let(:tournament) { create(:tournament_with_games) }
    it 'should update and return tournament' do
      patch "/tournaments/season_results/#{tournament.id}"
      expect(assigns(:tournament)).to be_present
      expect(flash[:success]).to match(/Season results successfully generated/)
    end
  end
end
