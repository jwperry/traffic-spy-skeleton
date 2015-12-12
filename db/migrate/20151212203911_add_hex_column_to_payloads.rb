class AddHexColumnToPayloads < ActiveRecord::Migration
  def change
    add_column :payloads, :hex, :integer
  end
end
