class CreateUserPrizes < ActiveRecord::Migration[6.0]
  def change
    create_table :user_prizes do |t|
      t.string :point
      t.references :prize, null: false, foreign_key: true
      t.datetime :expire_date
      t.references :user, null: false, foreign_key: true
      t.boolean :active

      t.timestamps
    end
  end
end
