class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :username
      t.string :password
      t.string :name
      t.string :email
      t.string :address
      t.string :creditcardnumber
      t.string :phonenumber

      t.timestamps
    end
  end
end
