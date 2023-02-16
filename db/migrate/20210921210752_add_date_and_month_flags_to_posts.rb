class AddDateAndMonthFlagsToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :hide_day, :boolean, default: false
    add_column :posts, :hide_month, :boolean, default: false
  end
end
