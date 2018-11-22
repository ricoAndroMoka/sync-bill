class AddTokenToAdvanceOrdering < ActiveRecord::Migration[5.2]
  def change
  	add_column :advance_orderings, :token, :string
  	add_column :advance_orderings, :token_created_at, :string
  	add_column :advance_orderings, :token_expired_at, :string

  	rename_column :advance_orderings, :business_id, :application_order_id
  	rename_column :advance_orderings, :event_type, :event_name
  end
end
