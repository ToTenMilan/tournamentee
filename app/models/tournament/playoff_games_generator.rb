# frozen_string_literal: true

class Tournament
  class PlayoffGamesGenerator
    def initialize(tournament, playoff_level)
      @tournament = tournament
      @playoff_level = playoff_level
    end

    def call
      # number_of_games = case @playoff_level
      #   when :quarterfinal then 4
      #   when :semifinal then 2
      #   when :final then 1
      # end
      ######## IN PLAYOFFS, next games are between teams with the most points from season, should be between winners of previous round
      #################################################################################################################################3
      # BUG in choosing teams to next round - there is no ordering by tournamententries in playoffs !!!!!!!!!!!!! ######################################################
      
      ##### this happens only on quarterfinal
      # case @playoff_level
      # when :quarterfinal
      #   create_games_for_quarterfinal_round
      # when :semifinal
      #   create_games_for_semifinal_round
      # when :final
      #   create_games_for_final_round
      # end
      self.send("create_games_for_#{@playoff_level}_round")
      @tournament
    end

    private

    # def create_games_for_playoff_round
    # end

    def create_games_for_final_round
      # create_playoff_game(1)
      @tournament.games.create(host_team_id: find_winner_id_of('Game 1'),
                               guest_team_id: find_winner_id_of('Game 2'),
                               playoff_level: @playoff_level,
                               game_type: :playoff,
                               name: "Game 1")
    end

    def create_games_for_semifinal_round
      @tournament.games.create(host_team_id: find_winner_id_of('Game 1'),
                               guest_team_id: find_winner_id_of('Game 2'),
                               playoff_level: @playoff_level,
                               game_type: :playoff,
                               name: "Game 1")
      @tournament.games.create(host_team_id: find_winner_id_of('Game 3'),
                               guest_team_id: find_winner_id_of('Game 4'),
                               playoff_level: @playoff_level,
                               game_type: :playoff,
                               name: "Game 2")
    end

    # def create_playoff_game(n)
    #   @tournament.games.create(host_team_id: find_winner_id_of("Game #{n+1}"),
    #                            guest_team_id: find_winner_id_of("Game #{n*2}"),
    #                            playoff_level: @playoff_level,
    #                            game_type: :playoff,
    #                            name: "Game #{n+1}")
    # end

    def create_games_for_quarterfinal_round
      div_a_entries = @tournament.tournament_entries.where('division = 0')#.order('total_points DESC') 
      div_b_entries = @tournament.tournament_entries.where('division = 1')
      4.times do |n|
        # (a's are host teams, b's are guest teams)
        # first loop  a = 0 b = 3
        # second loop a = 1 b = 2
        # third loop  a = 2 b = 1
        # fourth loop a = 3 b = 0
        a_index = n
        b_index = 3 - n
        game_index = n + 1
        game = @tournament.games.create(host_team_id: div_a_entries[a_index].team.id,  
                                        guest_team_id: div_b_entries[b_index].team.id,
                                        playoff_level: @playoff_level,
                                        game_type: :playoff,
                                        name: "Game #{game_index}")
      end
    end

    def find_winner_id_of(game_name)
      # playoff_level here is always one too much
      previous_level = Game.playoff_levels.key(Game.playoff_levels[@playoff_level].pred)
      lld '===============================prevvelel', previous_level
      lld 'query', @tournament.games.send(previous_level).inspect
      @tournament.games.send(previous_level).find_by(name: game_name).winner.id
    end
  end
end

      # div_a_entries = @tournament.teams.map do |team|
      #   team.tournament_entries.find_by(tournament_id: @tournament.id, division: 'a')
      # end.compact!
      # div_b_entries = @tournament.teams.map do |team|
      #   team.tournament_entries.find_by(tournament_id: @tournament.id, division: 'b')
      # end.compact!