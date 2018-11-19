class RemoveForeignKeyConstraints < ActiveRecord::Migration[5.2]
  def change
    remove_foreign_key :quotes, :books
    remove_foreign_key :comments, :quotes
    remove_foreign_key :comments, :books
  end
end
