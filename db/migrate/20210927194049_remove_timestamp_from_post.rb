class RemoveTimestampFromPost < ActiveRecord::Migration[6.1]
  def change
  	remove_column :posts, :timestamp
  end
end
