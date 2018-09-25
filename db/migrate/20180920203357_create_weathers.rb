class CreateWeathers < ActiveRecord::Migration[5.2]
  def change
    create_table :weathers do |t|
      t.string :city
      t.integer :date
      t.string :time
      t.string :temperature
      t.string :description
      t.string :windspeed
      t.timestamps
    end
  end
end