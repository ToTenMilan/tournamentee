# frozen_string_literal: true

class Tournament
  class PlayoffResultsGenerator
    include ResultsRandomizer
    def initialize(tournament, playoff_level)
      @tournament = tournament
      @playoff_level = playoff_level
    end

    def call
      @tournament.games.send(@playoff_level).each do |game|
        host_team_result = 0
        guest_team_result = 0
        while host_team_result == guest_team_result
          host_team_result = random_result
          guest_team_result = random_result
        end
        game.update(host_team_result: host_team_result, guest_team_result: guest_team_result)
      end
      @tournament.update(status: :done) if @playoff_level == :final
      @tournament
    end
  end
end
