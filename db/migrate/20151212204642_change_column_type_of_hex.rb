class ChangeColumnTypeOfHex < ActiveRecord::Migration
  def change
    change_column :payloads, :hex, :string
  end
end
