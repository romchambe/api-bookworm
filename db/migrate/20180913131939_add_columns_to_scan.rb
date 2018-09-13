class AddColumnsToScan < ActiveRecord::Migration[5.2]
  def change
    add_column :scans, :full_response, :text
    add_column :scans, :relevant_text, :text
  end
end
