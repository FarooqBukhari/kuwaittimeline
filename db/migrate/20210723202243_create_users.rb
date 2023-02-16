class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :name, limit: 100, null: false
      t.string :status, limit: 20
      t.integer :role, default: 0
      t.timestamps
    end
  end
end
