class CreateSubscriptions < ActiveRecord::Migration[5.2]
  def change
    create_table :subscriptions do |t|
    	t.integer :outlet_id
    	t.integer :business_id
    	t.string :item_name
    	t.text :item_variants

      t.timestamps
    end
  end
end
