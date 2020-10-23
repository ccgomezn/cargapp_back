class CreateVehicleDocuments < ActiveRecord::Migration[6.0]
  def change
    create_table :vehicle_documents do |t|
      t.references :document_type, null: false, foreign_key: true
      t.string :file
      t.references :statu, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.references :vehicle, null: false, foreign_key: true
      t.date :expire_date
      t.boolean :approved
      t.boolean :active

      t.timestamps
    end
  end
end
