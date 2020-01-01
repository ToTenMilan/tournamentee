# frozen_string_literal: true

def generate_games(tournament, teams, division)
  teams.each do |outer_team|
    teams.each do |inner_team|
      tournament.games.create(host_team_id: outer_team.id, guest_team_id: inner_team.id) do |g|
        g.division = division
        g.playoff_level = :seasonal_game
        g.game_type = outer_team.id != inner_team.id ? :seasonal : :seasonal_self_assigned
      end
    end

    outer_team.tournament_entries.find_or_create_by(tournament_id: tournament.id, division: division)
  end
end

def generate_results_for_season_games(tournament)
  # results = [0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,2,2,2,2,2,2,2,3,3,3,4,4,5,6,7,8,9]
  # rs = results.size
  tournament.games.each_with_index do |game, index|
    next if game.host_team_id === game.guest_team_id
    game.update(host_team_result: 2, guest_team_result: index)
  end
  tournament
end