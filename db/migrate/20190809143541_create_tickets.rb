class CreateTickets < ActiveRecord::Migration[6.0]
  def change
    create_table :tickets do |t|
      t.string :title
      t.text :body
      t.string :image
      t.string :media
      t.references :statu, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.boolean :active

      t.timestamps
    end
  end
end
