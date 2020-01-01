# frozen_string_literal: true

class TeamsController < ApplicationController
  def new
    @team = Team.new
  end

  def create
    @team = Team.new(team_params)
    if @team.save
      flash[:success] = "Team souccessfully created"
      redirect_to tournaments_path
    else
      # There is an issue with Turbolinks https://github.com/turbolinks/turbolinks/issues/60
      # that is modifying path from 'teams/new' to '/teams' after submission with errors.
      # Therefore browser's refresh button dont work as expected after invalid form submission
      render :new
    end
  end

  private

    def team_params
      params.require(:team).permit(:name)
    end
end
