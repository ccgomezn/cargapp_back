class AddCategoryToDocumentType < ActiveRecord::Migration[6.0]
  def change
    add_column :document_types, :category, :string
    add_reference :service_documents, :document_type, foreign_key: true
    remove_column :service_documents, :document_type, :string
    remove_column :services, :contact_name, :string
  end
end
