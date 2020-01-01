# frozen_string_literal: true

# class Tournament
#   class SeasonResultsCalculator
#     def initialize(tournament)
#       @tournament = tournament
#     end

#     def call
#       # should calculate the ledgers in each division
#       @tournament.games.each do |game|
#         next if game.host_team_id === game.guest_team_id
#         case
#           when game.host_team_result > game.guest_team_result
#             game.host_team_points = 3
#             game.guest_team_points = 0
#           when game.host_team_result < game.guest_team_result
#             game.host_team_points = 0
#             game.guest_team_points = 3
#           when game.host_team_result == game.guest_team_result
#             game.host_team_points = 1
#             game.guest_team_points = 1
#         end
#         game.save
#       end
#       @tournament
#     end
#   end
# end


# should generate 4 new games of level :quarterfinal, between winners of season, by the rule the best plays with the worst, and return @tournament