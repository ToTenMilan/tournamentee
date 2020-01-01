class ChangeTournamentGuestHostIndexOnGames < ActiveRecord::Migration[6.0]
  def change
    remove_index :games, [:tournament_id, :guest_team_id, :host_team_id]
    add_index :games, [:tournament_id, :guest_team_id, :host_team_id, :playoff_level], unique: true, name: 'unique_game_among_tournament_index'
  end
end
