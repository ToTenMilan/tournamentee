# frozen_string_literal: true

class Tournament
  class SeasonResultsGenerator
    include ResultsRandomizer

    def initialize(tournament)
      @tournament = tournament
    end

    def call
      @tournament.games.seasonal.each do |game|
        host_team_result = random_result
        guest_team_result = random_result
        host_team_points, guest_team_points = assign_points_according_to_results(host_team_result, guest_team_result)

        game.update(host_team_result: host_team_result, guest_team_result: guest_team_result)

        update_ledger_position(game, :host_team, host_team_points, host_team_result)
        update_ledger_position(game, :guest_team, guest_team_points, guest_team_result)
      end
      @tournament
    end
  
    private

    def update_ledger_position(game, team, points, goals)
      team_tournament_entry = game.send(team).tournament_entries.find_by(tournament_id: @tournament.id)
      team_tournament_entry.update(total_points: team_tournament_entry.total_points + points,
                                   total_goals: team_tournament_entry.total_goals + goals)
    end

    def assign_points_according_to_results(host_team_result, guest_team_result)
      case
        when host_team_result > guest_team_result then [3,0]
        when host_team_result < guest_team_result then [0,3]
        when host_team_result == guest_team_result then [1,1]
      end
    end
  end
end
