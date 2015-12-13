class AddVerbColumnToPayloads < ActiveRecord::Migration
  def change
    add_column :payloads, :verb_id, :integer
  end
end
