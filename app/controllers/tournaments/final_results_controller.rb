class Tournaments::FinalResultsController < ApplicationController
  def update
    @tournament = Tournament.find(params[:id])
    Tournament::PlayoffResultsGenerator.new(@tournament, :final).call
    # Tournament::PlayoffGamesGenerator.new(@tournament, :semifinal).call
    
    if @tournament.errors.blank?
      flash[:success] = "Final results successfully generated"
      redirect_to tournament_path(@tournament)
    end
  end
end
