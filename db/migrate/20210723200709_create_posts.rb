class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.string :subject_ar, limit: 250, null: false
      t.string :subject_en, limit: 250
      t.text :description_ar
      t.text :description_en
      t.string :reference, limit: 250
      t.datetime :timestamp
      t.date :date
      t.time :time
      t.integer :flag, default: 0, null: false
      t.string :status
      t.integer :views, default: 0, null: false

      t.timestamps
    end
  end
end
