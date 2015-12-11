class ChangeRooturlInApplications < ActiveRecord::Migration
  def change
    rename_column :applications, :rootUrl, :root_url
  end
end
