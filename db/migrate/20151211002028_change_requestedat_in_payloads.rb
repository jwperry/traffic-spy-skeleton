class ChangeRequestedatInPayloads < ActiveRecord::Migration
  def change
    rename_column :payloads, :requestedAt, :requested_at
  end
end
