class CreateDevices < ActiveRecord::Migration
  def change
    create_table :devices do |t|
      t.string :location
      t.string :ip_host
      t.string :device_type

      t.timestamps null: false
    end
  end
end
