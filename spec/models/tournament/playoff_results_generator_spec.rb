# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Tournament::PlayoffResultsGenerator, type: :model do
  context 'quarterfinal' do
    let(:tournament) { create(:tournament_with_playoff_games_generated, playoff_level: :quarterfinal, games_needed: 4 ) }
    it 'generates results for 4 quarterfinal games' do
      @tournament = described_class.new(tournament, :quarterfinal).call
      expect(@tournament.games.quarterfinal.map(&:host_team_result)).not_to include nil
      expect(@tournament.games.quarterfinal.map(&:guest_team_result)).not_to include nil 
    end
  end

  context 'semifinal' do
    let(:tournament) { create(:tournament_with_playoff_games_generated, playoff_level: :semifinal, games_needed: 2 ) }
    it 'generates results for 2 semifinal games' do
      @tournament = described_class.new(tournament, :semifinal).call
      expect(@tournament.games.semifinal.map(&:host_team_result)).not_to include nil
      expect(@tournament.games.semifinal.map(&:guest_team_result)).not_to include nil 
    end
  end

  context 'final' do
    let(:tournament) { create(:tournament_with_playoff_games_generated, playoff_level: :final, games_needed: 1 ) }
    it 'generates results for 1 final game' do
      @tournament = described_class.new(tournament, :final).call
      expect(@tournament.games.final.map(&:host_team_result)).not_to include nil
      expect(@tournament.games.final.map(&:guest_team_result)).not_to include nil 
    end
  end
end
