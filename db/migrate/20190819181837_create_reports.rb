class CreateReports < ActiveRecord::Migration[6.0]
  def change
    create_table :reports do |t|
      t.string :name
      t.string :origin
      t.string :destination
      t.string :cause
      t.string :sense
      t.string :novelty
      t.string :geolocation
      t.string :image
      t.date :start_date
      t.date :end_date
      t.string :report_type
      t.references :user, null: false, foreign_key: true
      t.boolean :active

      t.timestamps
    end
  end
end
