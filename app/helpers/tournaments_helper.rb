module TournamentsHelper
  def game_fill_for_guest_team(guest_team, division_number, opponent_position)
    game = @tournament.game_for(guest_team, division_number, opponent_position)
    show_results(game)
  end

  def show_results(game)
    "#{game.host_team_result} : #{game.guest_team_result}"
  end

  def generate_season_results_button
    if @tournament.playoff_level >= 1
      link_to "Generate season results", tournament_path(@tournament), class: 'btn btn-primary btn-sm disabled'
    else
      link_to "Generate season results", tournaments_season_result_path(@tournament), method: :patch, class: 'btn btn-primary btn-sm'
    end
  end

  def generate_quarterfinal_results_button
    if @tournament.playoff_level >= 2
      link_to "Generate quarterfinal results", tournament_path(@tournament), class: 'btn btn-primary btn-sm disabled'
    else
      link_to 'Generate quarterfinal results', tournaments_quarterfinal_result_path(@tournament), method: :patch, class: 'btn btn-primary btn-sm'
    end
  end

  def generate_semifinal_results_button
    if @tournament.playoff_level >= 3
      link_to "Generate semifinal results", tournament_path(@tournament), class: 'btn btn-primary btn-sm disabled'
    else
      # maybe the saem route with different params?????
      link_to 'Generate semifinal results', tournaments_semifinal_result_path(@tournament), method: :patch, class: 'btn btn-primary btn-sm'
    end
  end

  def generate_final_results_button
    if @tournament.playoff_level >= 4 ##### Change to ethod that checks whether final is played ######
      link_to "Generate final results", tournament_path(@tournament), class: 'btn btn-primary btn-sm disabled'
    else
      # maybe the saem route with different params?????
      link_to 'Generate final results', tournaments_final_result_path(@tournament), method: :patch, class: 'btn btn-primary btn-sm'
    end
  end
end
