class CreateFullUrlPaths < ActiveRecord::Migration
  def change
    create_table :full_url_paths do |t|
      t.string :full_url_path
    end
  end
end
