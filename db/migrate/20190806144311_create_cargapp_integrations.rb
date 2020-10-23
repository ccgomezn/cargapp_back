class CreateCargappIntegrations < ActiveRecord::Migration[6.0]
  def change
    create_table :cargapp_integrations do |t|
      t.string :name
      t.text :description
      t.string :provider
      t.string :code
      t.string :url
      t.string :url_provider
      t.string :url_production
      t.string :url_develop
      t.string :email
      t.string :username
      t.string :password
      t.string :phone
      t.string :pin
      t.string :token
      t.string :app_id
      t.string :client_id
      t.string :api_key
      t.references :user, null: false, foreign_key: true
      t.boolean :active

      t.timestamps
    end
  end
end
