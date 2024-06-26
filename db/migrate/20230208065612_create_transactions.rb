class CreateTransactions < ActiveRecord::Migration[6.1]
  def change
    create_table :transactions do |t|
      t.integer :quantity
      t.float :totalprice

      t.timestamps
    end
  end
end
