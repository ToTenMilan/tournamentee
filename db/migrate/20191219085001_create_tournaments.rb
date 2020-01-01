class CreateTournaments < ActiveRecord::Migration[6.0]
  def change
    create_table :tournaments do |t|
      t.string :name, null: false
      t.integer :status, null: false, default: 0

      t.timestamps
    end
    add_index :tournaments, :name, unique: true
  end
end
