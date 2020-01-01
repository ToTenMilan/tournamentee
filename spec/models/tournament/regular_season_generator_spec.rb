# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Tournament::RegularSeasonGenerator, type: :model do
  context 'generating tournament' do
    let(:name) { { name: 'test-tournament' } }
    let(:tournament) { Tournament.new }
    let(:teams) { create_list(:team, 16) }
    before(:each) do
      @tournament = described_class.new(name, tournament, teams).call
    end

    it 'should create new instance of Tournament' do
      expect(@tournament).to be_instance_of(Tournament)
    end

    it 'should have 128 games' do
      expect(@tournament.games.size).to be 128
    end

    it 'should have 16 host teams' do
      expect(@tournament.host_teams.size).to be 16
    end

    it 'should have 16 guest teams' do
      expect(@tournament.guest_teams.size).to be 16
    end

    it 'should have 112 seasonal games' do
      seasonal_games = @tournament.games.where(game_type: :seasonal).size
      expect(seasonal_games).to be 112
    end

    it 'should have 16 seasonal self assigned games that wont be played (same team for Host and Guest)' do
      seasonal_games = @tournament.games.where(game_type: :seasonal_self_assigned).size
      expect(seasonal_games).to be 16
    end

    it 'should have 64 games in each division' do
      divisions = @tournament.games.each(&:division)
      division_a_games = divisions.select(&:a?).size
      division_b_games = divisions.select(&:b?).size
      expect(division_a_games).to be 64
      expect(division_b_games).to be 64
    end

    it 'should change status to in_progress' do
      expect(@tournament.status).to eq 'in_progress'
    end

    it 'should change playoff_level to quarterfinal' do
      expect(@tournament.playoff_level).to eq 'seasonal_game'
    end

    it 'should create 16 tournament entries for tournament' do
      expect(@tournament.tournament_entries.size).to be 16
    end
  end
end
