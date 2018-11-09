class ChangeBookToAuthorInBooks < ActiveRecord::Migration[5.2]
  def change
    rename_column :books, :book, :author
  end
end
