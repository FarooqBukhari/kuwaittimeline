class AddUserToPost < ActiveRecord::Migration[6.1]
  def change
    add_reference :posts, :user, required: false, foreign_key: true
  end
end
