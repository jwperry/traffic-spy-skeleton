class AddFullUrlPathIdToPayloads < ActiveRecord::Migration
  def change
    add_column :payloads, :full_url_path_id, :integer
  end
end