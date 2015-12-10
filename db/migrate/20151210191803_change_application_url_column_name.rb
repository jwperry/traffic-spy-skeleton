class ChangeApplicationUrlColumnName < ActiveRecord::Migration
  def change
    rename_column(:applications, :rootUrl, :rootUrl)
  end
end
