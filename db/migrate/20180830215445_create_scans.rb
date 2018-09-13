class CreateScans < ActiveRecord::Migration[5.2]
  def change
    create_table :scans do |t|
      t.references :user, foreign_key: true
      t.integer :note_id
      t.string :name

      t.timestamps
    end
  end
end
