class CreateGames < ActiveRecord::Migration[6.0]
  def change
    create_table :games do |t|
      t.integer :tournament_id, null: false, foreign_key: true
      t.integer :guest_team_id, foreign_key: true
      t.integer :host_team_id, foreign_key: true
      t.string  :name
      t.integer :game_type
      t.boolean :played, default: false, null: false
      t.integer :guest_team_result
      t.integer :host_team_result
      t.integer :playoff_level
      t.integer :division

      t.timestamps
    end
    add_index :games, :tournament_id
    add_index :games, :guest_team_id
    add_index :games, :host_team_id
    add_index :games, :name
    add_index :games, [:tournament_id, :guest_team_id, :host_team_id], unique: true
  end
end
