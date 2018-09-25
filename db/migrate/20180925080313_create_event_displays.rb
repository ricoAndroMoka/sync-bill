class CreateEventDisplays < ActiveRecord::Migration[5.2]
  def change
    create_table :event_displays do |t|
      t.integer, :outlet_id
      t.integer, :business_id
      t.string, :token
      t.string :type

      t.timestamps
    end
  end
end
