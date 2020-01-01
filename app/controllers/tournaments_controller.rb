# frozen_string_literal: true

class TournamentsController < ApplicationController
  def index
    @tournaments = Tournament.includes(:tournament_entries, games: [:host_team, :guest_team]).all
    @tournament = Tournament.new
  end

  def show
    @tournament = Tournament.includes(:tournament_entries, games: [:host_team, :guest_team]).find(params[:id])
  end

  def create
    teams = Team.where(id: tournament_params[:team_ids]).to_a
    @tournament = Tournament::RegularSeasonGenerator.new(tournament_params[:name], Tournament.new, teams).call
    if @tournament.errors.blank?
      flash[:success] = "Tournament successfully created"
      redirect_to tournament_path(@tournament)
    else
      @tournaments ||= Tournament.all
      render :index
    end
  end

  private

  def tournament_params
    params.require(:tournament).permit(:name, team_ids: [])
  end
end
