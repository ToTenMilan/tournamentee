class AddLedgerColumnsToTournamentEntries < ActiveRecord::Migration[6.0]
  def change
    add_column :tournament_entries, :division, :integer
    add_column :tournament_entries, :total_points, :integer, null: false, default: 0
  end
end
