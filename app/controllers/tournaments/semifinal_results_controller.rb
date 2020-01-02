# frozen_string_literal: true

module Tournaments
  class SemifinalResultsController < ApplicationController
    def update
      @tournament = Tournament.find(params[:id])
      Tournament::PlayoffResultsGenerator.new(@tournament, :semifinal).call
      Tournament::PlayoffGamesGenerator.new(@tournament, :final).call
      
      if @tournament.errors.blank?
        flash[:success] = "Semifinal results successfully generated"
        redirect_to tournament_path(@tournament)
      end
    end
  end  
end
