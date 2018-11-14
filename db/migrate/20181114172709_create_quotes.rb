class CreateQuotes < ActiveRecord::Migration[5.2]
  def change
    create_table :quotes do |t|
      t.references :book, foreign_key: true
      t.string :title
      t.text :content

      t.timestamps
    end
  end
end
