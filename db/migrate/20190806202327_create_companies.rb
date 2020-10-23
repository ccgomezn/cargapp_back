class CreateCompanies < ActiveRecord::Migration[6.0]
  def change
    create_table :companies do |t|
      t.string :name
      t.text :description
      t.string :company_type
      t.references :load_type, null: false, foreign_key: true
      t.string :sector
      t.string :legal_representative
      t.string :address
      t.string :phone
      t.references :user, null: false, foreign_key: true
      t.date :constitution_date
      t.boolean :active

      t.timestamps
    end
  end
end
