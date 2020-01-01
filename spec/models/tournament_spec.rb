# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Tournament, type: :model do
  # it 'should have its attributes' do
  #   tournament = build(:tournament)
  #   expect(tournament.name).to be_present
  #   expect(tournament.status).to eq 'draft'
  # end

  # context 'relationships' do
  #   it 'should have its relationships' do
  #     tournament = create(:tournament_with_games_light)
  #     expect(tournament.games.size).to be 8
  #     expect(tournament.host_teams.size).to be 8
  #     expect(tournament.guest_teams.size).to be 8
  #   end
  # end

  context 'ordering teams' do
    let(:tournament) { create(:tournament_with_games_light) }
    it 'should order host_teams by name' do
      tournament.host_teams.first.update(name: 'aab')
      tournament.host_teams.second.update(name: 'aaa')
      tournament.host_teams.third.update(name: 'zzz')
      expect(tournament.host_teams.first.name).to eq 'aaa'
      expect(tournament.host_teams.second.name).to eq 'aab'
      expect(tournament.host_teams.last.name).to eq 'zzz'
    end

    it 'should order guest_teams by name' do
      tournament.guest_teams.first.update(name: 'aab')
      tournament.guest_teams.second.update(name: 'aaa')
      tournament.guest_teams.third.update(name: 'zzz')
      expect(tournament.guest_teams.first.name).to eq 'aaa'
      expect(tournament.guest_teams.second.name).to eq 'aab'
      expect(tournament.guest_teams.last.name).to eq 'zzz'
    end
  end

  context 'ordering tournament_entries' do
    it 'should order tournament_entries descending by total points' do
      tournament = create(:tournament)
      team1 = create(:team)
      team2 = create(:team)
      team3 = create(:team)
      tournament.teams << team1 << team2 << team3
      tournament.teams.find(team1.id).tournament_entries.first.update(total_points: 3)
      tournament.teams.find(team2.id).tournament_entries.first.update(total_points: 4)
      tournament.teams.find(team3.id).tournament_entries.first.update(total_points: 1)
      expect(tournament.teams.to_a).to eq [team2, team1, team3]
    end
  end

  # context 'validating number of teams' do
  #   it 'should generate tournament if there are 16 teams passed to generator' do
  #     tournament = build(:tournament_with_teams, tournament_entries_count: 16)
  #     tournament.save
  #     expect(tournament.teams.size).to be 16
  #   end

  #   it 'should raise validation error if there are less than 16 teams passed to generate tournament' do
  #     expect {
  #       tournament = build(:tournament_with_teams, tournament_entries_count: 15)
  #       pp tournament.teams
  #       tournament.reload.save
  #     }.to raise_error(an_instance_of(ActiveRecord::RecordInvalid))
  #   end

  #   it 'should raise validation error if there are more than 16 teams passed to generate tournament' do
  #     expect {
  #       tournament = build(:tournament_with_teams, tournament_entries_count: 17)
  #       tournament.save
  #     }.to raise_error(an_instance_of(ActiveRecord::RecordInvalid))
  #   end
  # end
end
