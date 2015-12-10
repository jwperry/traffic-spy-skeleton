class ChangeUrlIdInPayloads < ActiveRecord::Migration
  def change
    rename_column :payloads, :url_id, :url_id
  end
end
