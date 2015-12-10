class AddRootUrlToApplications < ActiveRecord::Migration
  def change
    add_column :applications, :rootUrl, :string
  end
end
