class AddEventInBookEvent < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :book, :string unless column_exists? :posts, :book
  end
end
