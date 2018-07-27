class AddContentToNotes < ActiveRecord::Migration[5.2]
  def change
    add_column :notes, :content, :text
  end
end
