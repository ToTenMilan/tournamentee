# frozen_string_literal: true

module TournamentsHelper
  def game_fill_for_guest_team(tournament, guest_team, division_number, opponent_position)
    game = tournament.game_for(guest_team, division_number, opponent_position)
    show_results(game)
  end

  def show_results(game)
    "#{game.host_team_result} : #{game.guest_team_result}"
  end

  def generate_season_results_button(tournament)
    if tournament.playoff_level >= 1
      link_to "Generate season results", tournament_path(tournament), class: 'btn btn-primary btn-sm disabled'
    else
      link_to "Generate season results", tournaments_season_result_path(tournament), method: :patch, class: 'btn btn-primary btn-sm'
    end
  end

  def generate_quarterfinal_results_button(tournament)
    if tournament.playoff_level >= 2
      link_to "Generate quarterfinal results", tournament_path(tournament), class: 'btn btn-primary btn-sm disabled'
    else
      link_to 'Generate quarterfinal results', tournaments_quarterfinal_result_path(tournament), method: :patch, class: 'btn btn-primary btn-sm'
    end
  end

  def generate_semifinal_results_button(tournament)
    if tournament.playoff_level >= 3
      link_to "Generate semifinal results", tournament_path(tournament), class: 'btn btn-primary btn-sm disabled'
    else
      link_to 'Generate semifinal results', tournaments_semifinal_result_path(tournament), method: :patch, class: 'btn btn-primary btn-sm'
    end
  end

  def generate_final_results_button(tournament)
    if tournament.finals_finished?
      link_to "Generate final results", tournament_path(tournament), class: 'btn btn-primary btn-sm disabled'
    else
      link_to 'Generate final results', tournaments_final_result_path(tournament), method: :patch, class: 'btn btn-primary btn-sm'
    end
  end

  def show_winner(tournament)
    tournament.winner.name if tournament.finals_finished?
  end

  def show_finalist(tournament, team)
    final_game = tournament.games.final.first
    tournament.games.final.first.send(team).name if final_game
  end
end
