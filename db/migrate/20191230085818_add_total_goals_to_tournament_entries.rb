class AddTotalGoalsToTournamentEntries < ActiveRecord::Migration[6.0]
  def change
    add_column :tournament_entries, :total_goals, :integer, null: false, default: 0
  end
end
