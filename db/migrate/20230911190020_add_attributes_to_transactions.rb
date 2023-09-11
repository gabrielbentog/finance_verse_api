class AddAttributesToTransactions < ActiveRecord::Migration[7.0]
  def change
    add_column :transactions, :amount, :decimal
    add_column :transactions, :date, :date
    add_column :transactions, :item_name, :string
    add_column :transactions, :description, :text
  end
end
