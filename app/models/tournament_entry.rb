class TournamentEntry < ApplicationRecord
  belongs_to :team
  belongs_to :tournament
  # validates :team, uniqueness: { scope: :team_id, message: 'is already assigned to this tournament' } #should be validates tournament_id {scope: team_id}
  enum division: [:a, :b]
end
