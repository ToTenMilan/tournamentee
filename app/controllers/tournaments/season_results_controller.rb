# frozen_string_literal: true

module Tournaments
  class SeasonResultsController < ApplicationController
    def update
      @tournament = Tournament.find(params[:id])
      Tournament::SeasonResultsGenerator.new(@tournament).call
      Tournament::PlayoffGamesGenerator.new(@tournament, :quarterfinal).call
      if @tournament.errors.blank?
        flash[:success] = "Season results successfully generated"
        redirect_to tournament_path(@tournament)
      end
    end
  end
end
