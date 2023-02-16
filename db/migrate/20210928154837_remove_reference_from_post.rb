class RemoveReferenceFromPost < ActiveRecord::Migration[6.1]
  def change
    remove_column :posts, :reference
  end
end
