class ChangeUrlColumnName < ActiveRecord::Migration
  def change
    rename_column :urls, :url, :url
  end
end
