class AddRootUrlToApplications < ActiveRecord::Migration
  def change
    add_column :applications, :root_url, :string
  end
end
