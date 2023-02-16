class CreateReferenceTable < ActiveRecord::Migration[6.1]
  def change
    create_table :references do |t|
      t.string :reference_url, null: false
      t.references :post
      t.timestamps
    end
  end
end
