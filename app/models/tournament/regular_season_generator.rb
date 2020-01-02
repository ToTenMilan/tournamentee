# frozen_string_literal: true

class Tournament
  class RegularSeasonGenerator
    def initialize(name, tournament, teams)
      @name = name
      @tournament = tournament
      @teams = teams
    end

    def call
      @tournament.name = @name
      if @teams.size != 16
        @tournament.errors.add(:base, 'Tournament must have 16 teams assigned on order to be created')
        return @tournament
      end
      if @tournament.save
        divide_teams(@tournament, @teams[0,8], :a)
        divide_teams(@tournament, @teams[8,15], :b)
        @tournament.status = :in_progress
        @tournament.save
      end
      @tournament
    end

    private

    def divide_teams(tournament, teams, division)
      teams.each do |outer_team|
        teams.each_with_index do |inner_team, index|
          tournament.games.create(host_team_id: outer_team.id, guest_team_id: inner_team.id) do |g|
            g.division = division
            g.playoff_level = :seasonal_game
            g.game_type = outer_team.id != inner_team.id ? :seasonal : :seasonal_self_assigned
          end
        end
        outer_team.tournament_entries.find_or_create_by(tournament_id: tournament.id, division: division)
      end
    end
  end
end
