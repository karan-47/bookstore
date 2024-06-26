class AddDetailsToTransactions < ActiveRecord::Migration[6.1]
  def change
    add_reference :transactions, :book, null: false, foreign_key: true
    add_reference :transactions, :user, null: false, foreign_key: true
    add_column :transactions, :creditcardnumber, :string
    add_column :transactions, :address, :string
    add_column :transactions, :phonenumber, :string
  end
end
