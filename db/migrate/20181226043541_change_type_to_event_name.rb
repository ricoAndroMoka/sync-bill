class ChangeTypeToEventName < ActiveRecord::Migration[5.2]
  def change
  	rename_column :event_displays, :type, :event_name
  end
end
