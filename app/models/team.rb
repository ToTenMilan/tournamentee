# frozen_string_literal: true

class Team < ApplicationRecord
  validates :name, uniqueness: { case_sensitive: true }, presence: true
  has_many :host_games, class_name: 'Game', foreign_key: :host_team_id, dependent: :destroy, inverse_of: :host_team
  has_many :guest_games, class_name: 'Game', foreign_key: :guest_team_id, dependent: :destroy, inverse_of: :guest_team
  has_many :tournament_entries, dependent: :destroy

  def tournaments
    Tournament.joins(:games).where("games.host_team_id = ? OR games.guest_team_id = ?", self.id, self.id)
  end
end
