class CreateBills < ActiveRecord::Migration
  def change
    create_table :bills do |t|
      t.integer :user_id, null: false
      t.string :name, null: false
      t.integer :due_day, null: false
      t.timestamps null: false
    end
  end
end
