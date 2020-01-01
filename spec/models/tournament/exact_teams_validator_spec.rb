# # frozen_string_literal: true

# require 'rails_helper'

# RSpec.describe Tournament::SixteenTeamsValidator, type: :model do
#   it 'should generate tournament if there are 16 teams passed to generator' do
#     tournament = create(:tournament_with_teams, tournament_entries_count: 16)
#     expect(tournament.teams.size).to be 16
#   end

#   it 'should raise validation error if there are less than 16 teams passed to generate tournament' do
#     expect {
#       tournament = create(:tournament_with_teams, tournament_entries_count: 15)
#     }.to raise_error(an_instance_of(ActiveRecord::RecordInvalid))
#   end

#   it 'should raise validation error if there are more than 16 teams passed to generate tournament' do
#     expect {
#       tournament = create(:tournament_with_teams, tournament_entries_count: 17)
#     }.to raise_error(an_instance_of(ActiveRecord::RecordInvalid))
#   end
# end