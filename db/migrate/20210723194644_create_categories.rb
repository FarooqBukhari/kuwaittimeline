class CreateCategories < ActiveRecord::Migration[6.1]
  def change
    create_table :categories do |t|
      t.string :name_ar, limit: 100, null: false
      t.string :name_en, limit: 100, null: false
      t.string :slug, limit: 100, null: false
      t.boolean :active, default: false
      t.timestamps
    end
  end
end
