class AddPointsToGames < ActiveRecord::Migration[6.0]
  def change
    add_column :games, :host_team_points, :integer
    add_column :games, :guest_team_points, :integer
  end
end
