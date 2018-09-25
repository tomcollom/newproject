class AddFields < ActiveRecord::Migration[5.2]
  def change
    add_column :weathers, :humidity, :string
    add_column :weathers, :barometer, :string
    add_column :weathers, :visibility, :string
  end
end
