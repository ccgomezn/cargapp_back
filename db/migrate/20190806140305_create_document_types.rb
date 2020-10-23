class CreateDocumentTypes < ActiveRecord::Migration[6.0]
  def change
    create_table :document_types do |t|
      t.string :name
      t.string :code
      t.text :description
      t.boolean :active

      t.timestamps
    end
  end
end
