# frozen_string_literal: true

module Tournaments
  class QuarterfinalResultsController < ApplicationController
    def update
      @tournament = Tournament.find(params[:id])
      Tournament::PlayoffResultsGenerator.new(@tournament, :quarterfinal).call
      Tournament::PlayoffGamesGenerator.new(@tournament, :semifinal).call
      if @tournament.errors.blank?
        flash[:success] = "Quarterfinal results successfully generated"
        redirect_to tournament_path(@tournament)
      end
    end
  end
end
