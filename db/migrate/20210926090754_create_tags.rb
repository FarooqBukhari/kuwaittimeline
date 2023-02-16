class CreateTags < ActiveRecord::Migration[6.1]
  def change
    create_table :tags do |t|
      t.string :name_en
      t.string :name_ar

      t.timestamps
    end

     create_table :posts_tags, id: false do |t|
      	t.belongs_to :post
      	t.belongs_to :tag
    end
  end
end
