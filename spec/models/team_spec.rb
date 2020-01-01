# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Team, type: :model do
  # it 'should have its attributes' do
  #   team = build(:team)
  #   expect(team.name).to be_present
  # end

  # it 'should have its direct relationships' do
  #   team = build(:team)
  #   tournament = build(:tournament)
  #   team.tournaments_via_entries = tournament
  #   expect(team.tournaments_via_entries).to be_present
  # end

  context 'differentiate between two types of teams' do
    before do
      @tournament = create(:tournament_with_games_light)
    end
    let(:host_team) { @tournament.host_teams.first }
    let(:guest_team) { @tournament.guest_teams.first }

    context 'host team' do
      it 'should have its relationships through games' do
        expect(host_team.tournaments.size).to be 1
        expect(host_team.host_games.size).to be 1
      end
    end
  
    context 'guest team' do
      it 'should have its relationships through games' do
        expect(guest_team.tournaments.size).to be 1
        expect(guest_team.guest_games.size).to be 1
      end
    end
  end
end
