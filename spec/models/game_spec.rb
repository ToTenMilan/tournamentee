# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Game, type: :model do
  # it 'has its attributes' do
  #   game = build(:game) do |g|
  #     g.game_type = :seasonal
  #     g.played = true
  #     g.guest_team_result = 0
  #     g.host_team_result = 1
  #     g.playoff_level = :seasonal_game
  #     g.division = :a
  #   end
  #   expect(game.game_type).to eq 'seasonal'
  #   expect(game.played).to be true
  #   expect(game.guest_team_result).to be 0
  #   expect(game.host_team_result).to be 1
  #   expect(game.playoff_level).to eq 'seasonal_game'
  #   expect(game.division).to eq 'a'
  # end

  it 'is unique among tournament, guest_team and host_team' do
    create(:game)
    expect {
      create(:duplicated_game)
    }.to raise_error(an_instance_of(ActiveRecord::RecordInvalid).and having_attributes(message: "Validation failed: Tournament already has this game"))
  end
end
