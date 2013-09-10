class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.date :date
      t.datetime :hour
      t.string :name
      t.string :location
      t.string :description

      t.timestamps
    end
  end
end
