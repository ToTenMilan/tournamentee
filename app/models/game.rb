# frozen_string_literal: true

class Game < ApplicationRecord
  validates :tournament, uniqueness: { scope: [:host_team, :guest_team, :playoff_level], message: 'already has this game' }
  validate { host_team && guest_team }
  belongs_to :tournament
  belongs_to :guest_team, class_name: 'Team', optional: true
  belongs_to :host_team, class_name: 'Team', optional: true
  

  enum game_type: [:seasonal, :playoff, :seasonal_self_assigned]
  enum playoff_level: [:seasonal_game, :quarterfinal, :semifinal, :final]
  enum division: [:a, :b]

  def winner
    if host_team_result > guest_team_result
      host_team
    elsif host_team_result < guest_team_result
      guest_team
    else
      nil
    end
  end
end
