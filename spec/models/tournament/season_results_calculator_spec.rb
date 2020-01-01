# # frozen_string_literal: true

# require 'rails_helper'

# RSpec.describe Tournament::SeasonResultsCalculator, type: :model do
#   context 'basic behavior' do
#     it 'should return updated tournament' do
#       tournament = create(:tournament)
#       updated_tournament = described_class.new(tournament).call
#       expect(updated_tournament).to be_instance_of(Tournament)
#     end
#   end

#   context 'assigning points (according to polish "Ekstraklasa" rules)' do
#     let(:tournament) { create(:tournament_with_games_with_season_results)}
#     before do
#       Tournament::SeasonResultsCalculator.new(tournament).call
#       @games = tournament.games.where('host_team_id != guest_team_id')
#     end
#     it 'should properly assign points when host team lose' do
#       game = @games.where('host_team_result < guest_team_result').first
#       expect(game.host_team_points).to be 0
#       expect(game.guest_team_points).to be 3
#     end
#     it 'should properly assign points when there is a draw' do
#       game = @games.where('host_team_result = guest_team_result').first
#       expect(game.host_team_points).to be 1
#       expect(game.guest_team_points).to be 1
#     end
#     it 'should properly assign points when guest team lose' do
#       game = @games.where('host_team_result > guest_team_result').first
#       expect(game.host_team_points).to be 3
#       expect(game.guest_team_points).to be 0
#     end
#   end
# end
