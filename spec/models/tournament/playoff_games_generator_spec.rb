# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Tournament::PlayoffGamesGenerator, type: :model do
  describe 'quarterfinal' do
    context 'creates 4 games between teams of both divisions, by the rule "the best of "a" plays with the worst of "b""' do
      let(:tournament) { create(:tournament_with_finished_season, teams_count: 8) }
      before do
        t = described_class.new(tournament, :quarterfinal).call
        @games = t.games
        @div_a_entries = t.tournament_entries.where('division = 0')
        @div_b_entries = t.tournament_entries.where('division = 1')
      end
      it 'create game where first team from "a" plays with last team from "b"' do
        expect(@games.first.host_team).to eq @div_a_entries.first.team
        expect(@games.first.guest_team).to eq @div_b_entries.fourth.team
        expect(@games.first.playoff_level).to eq 'quarterfinal'
        expect(@games.first.game_type).to eq 'playoff'
      end
      
      it 'create game where second team from "a" plays with third team from "b"' do
        expect(@games.second.host_team).to eq @div_a_entries.second.team
        expect(@games.second.guest_team).to eq @div_b_entries.third.team
        expect(@games.second.playoff_level).to eq 'quarterfinal'
        expect(@games.second.game_type).to eq 'playoff'
      end

      it 'create game where third team from "a" plays with second team from "b"' do
        expect(@games.third.host_team).to eq @div_a_entries.third.team
        expect(@games.third.guest_team).to eq @div_b_entries.second.team
        expect(@games.third.playoff_level).to eq 'quarterfinal'
        expect(@games.third.game_type).to eq 'playoff'
      end

      it 'create game where last team from "a" plays with first team from "b"' do
        expect(@games.fourth.host_team).to eq @div_a_entries.fourth.team
        expect(@games.fourth.guest_team).to eq @div_b_entries.first.team
        expect(@games.fourth.playoff_level).to eq 'quarterfinal'
        expect(@games.fourth.game_type).to eq 'playoff'
      end

      it 'orders secondary by total goals in case total points is the same number' do
        out_of_playoffs_team = create(:team)
        tournament.teams << out_of_playoffs_team
        out_of_playoffs_team.tournament_entries.first.update(total_points: 0, total_goals: 0, division: 'a')
        div_a_fourth_team = tournament.teams.where("tournament_entries.division = 'a'").fourth
        div_a_fifth_team = tournament.teams.where("tournament_entries.division = 'a'").fifth
        expect(div_a_fourth_team.tournament_entries.first.total_goals).to be 1
        expect(div_a_fifth_team.tournament_entries.first.total_goals).to be 0
        expect(div_a_fifth_team).to eq out_of_playoffs_team
      end
    end
  end

  describe 'semifinal' do
    context 'creates 2 games between quarterfinal winners' do
      let(:tournament) { create(:tournament_with_finished_quarterfinal) }
      before do
        @tournament = described_class.new(tournament, :semifinal).call
        @quarterfinal = tournament.games.quarterfinal
      end

      it 'place winners of 1st and 2ng quarterfinal game against each other' do
        semifinal_game_1 = tournament.games.semifinal.find_by(name: 'Game 1')
        expect(semifinal_game_1.host_team).to eq @quarterfinal.find_by(name: 'Game 1').winner
        expect(semifinal_game_1.guest_team).to eq @quarterfinal.find_by(name: 'Game 2').winner
      end

      it 'place winners of 3rd and 4th quarterfinal game against each other' do
        semifinal_game_2 = tournament.games.semifinal.find_by(name: 'Game 2')
        expect(semifinal_game_2.host_team).to eq @quarterfinal.find_by(name: 'Game 3').winner
        expect(semifinal_game_2.guest_team).to eq @quarterfinal.find_by(name: 'Game 4').winner
      end
    end
  end

  describe 'final' do
    context 'creates 1 game between semifinal winners' do
      let(:tournament) { create(:tournament_with_finished_semifinal) }
      before do
        @tournament = described_class.new(tournament, :final).call
        @semifinal = tournament.games.semifinal
      end
      
      it 'place winners of semifinal games against each other' do
        final_game = tournament.games.final.find_by(name: 'Game 1')
        expect(final_game.host_team).to eq @semifinal.find_by(name: 'Game 1').winner
        expect(final_game.guest_team).to eq @semifinal.find_by(name: 'Game 2').winner
      end
    end
  end
end

