class RenameNotesToBooks < ActiveRecord::Migration[5.2]
  def change
    rename_table :notes, :books
  end
end
