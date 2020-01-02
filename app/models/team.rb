# frozen_string_literal: true

class Team < ApplicationRecord
  validates :name, uniqueness: { case_sensitive: true }, presence: true
  has_many :host_games, class_name: 'Game', foreign_key: :host_team_id, dependent: :destroy, inverse_of: :host_team
  has_many :guest_games, class_name: 'Game', foreign_key: :guest_team_id, dependent: :destroy, inverse_of: :guest_team
  has_many :tournament_entries, dependent: :destroy

  def tournaments
    Tournament.joins(:games).where("games.host_team_id = ? OR games.guest_team_id = ?", self.id, self.id)
  end

  def games_played(tournament)
    query = ['game_type = 0 AND tournament_id = ? AND host_team_result IS NOT NULL AND guest_team_result IS NOT NULL', tournament.id]
    (guest_games.where(query).count + host_games.where(query).count).to_f * 100.0 / 14.0
  end

  def wins(tournament)
    guest_wins = guest_games.where('game_type = 0 AND
                                    tournament_id = ? AND
                                    guest_team_result > host_team_result', tournament.id).size
    host_wins = host_games.where('game_type = 0 AND
                                  tournament_id = ? AND
                                  host_team_result > guest_team_result', tournament.id).size
    guest_wins + host_wins
  end
end
