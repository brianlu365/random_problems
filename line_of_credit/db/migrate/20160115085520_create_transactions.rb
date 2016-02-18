class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.integer :day_number
      t.float :change_amount
      t.string :type

      t.timestamps null: false
    end
  end
end
