class CreateTransactionTypes < ActiveRecord::Migration[7.0]
  def change
    create_table :transaction_types do |t|
      t.string :name
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
