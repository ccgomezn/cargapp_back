class CreateMessages < ActiveRecord::Migration[6.0]
  def change
    create_table :messages do |t|
      t.references :room, null: false, foreign_key: true
      t.string :message_type
      t.string :uuid
      t.string :message
      t.string :file
      t.references :user, null: false, foreign_key: true
      t.boolean :active

      t.timestamps
    end
  end
end
