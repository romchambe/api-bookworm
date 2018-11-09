class RenameScansToQuote < ActiveRecord::Migration[5.2]
  def change
    rename_table :scans, :quotes
  end
end
