class ChangeRespondedinInPayloads < ActiveRecord::Migration
  def change
    rename_column :payloads, :respondedIn, :responded_in
  end
end
