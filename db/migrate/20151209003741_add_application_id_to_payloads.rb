class AddApplicationIdToPayloads < ActiveRecord::Migration
  def change
    add_column :payloads, :application_id, :integer
  end
end
