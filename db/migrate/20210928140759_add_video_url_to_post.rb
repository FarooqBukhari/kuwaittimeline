class AddVideoUrlToPost < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :video_url, :string
  end
end
