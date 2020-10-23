class CreateUserChallenges < ActiveRecord::Migration[6.0]
  def change
    create_table :user_challenges do |t|
      t.integer :position
      t.integer :point
      t.references :challenge, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.boolean :active

      t.timestamps
    end
  end
end
