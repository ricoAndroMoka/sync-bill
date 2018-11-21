class CreateAdvanceOrderings < ActiveRecord::Migration[5.2]
  def change
    create_table :advance_orderings do |t|

    	t.integer :outlet_id
    	t.integer :business_id
    	t.string :event_type
    	t.text :additional_data

      t.timestamps
    end
  end
end
