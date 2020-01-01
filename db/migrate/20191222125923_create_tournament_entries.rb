class CreateTournamentEntries < ActiveRecord::Migration[6.0]
  def change
    create_table :tournament_entries do |t|
      t.references :team, null: false, foreign_key: true
      t.references :tournament, null: false, foreign_key: true

      t.timestamps
    end
    add_index :tournament_entries, [:tournament_id, :team_id], unique: true
  end
end
