# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Tournament::SeasonResultsGenerator, type: :model do
  context 'basic behavior' do
    it 'should return updated tournament' do
      tournament = create(:tournament)
      updated_tournament = described_class.new(tournament).call
      expect(updated_tournament).to be_instance_of(Tournament)
    end
  end

  context 'generating random results for season games' do
    let(:tournament) { create(:tournament_with_games)}
    before do
      @updated_tournament = described_class.new(tournament).call
    end

    it "should assign random results to host_team_result's and guest_team_results's of all games except self assigned season games (112 out of 128 games)" do
      games = @updated_tournament.games
      host_team_results = games.pluck(:host_team_result).compact
      guest_team_results = games.pluck(:guest_team_result).compact
      expect(host_team_results.size).to be 112
      expect(guest_team_results.size).to be 112
    end

    it 'should update tournament_entries of teams with points' do
      expect(@updated_tournament.tournament_entries.map(&:total_points)).to_not include nil
    end
  end
end
