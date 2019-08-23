class CreateServiceDocuments < ActiveRecord::Migration[6.0]
  def change
    create_table :service_documents do |t|
      t.string :name
      t.string :document_type
      t.string :document
      t.references :service, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.boolean :active

      t.timestamps
    end
  end
end
