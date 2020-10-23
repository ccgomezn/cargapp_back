class CreateProfiles < ActiveRecord::Migration[6.0]
  def change
    create_table :profiles do |t|
      t.string :firt_name
      t.string :last_name
      t.string :avatar
      t.string :phone
      t.string :document_id
      t.references :document_type, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.date :birth_date

      t.timestamps
    end
  end
end
