class ChangeUrlTableName < ActiveRecord::Migration
  def change
    rename_table :urls, :urls
  end
end
