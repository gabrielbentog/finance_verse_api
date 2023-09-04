class CreateUserCryptos < ActiveRecord::Migration[7.0]
  def change
    create_table :user_cryptos do |t|
      t.references :user, foreign_key: true
      t.references :crypto, foreign_key: true

      t.timestamps
    end
  end
end
