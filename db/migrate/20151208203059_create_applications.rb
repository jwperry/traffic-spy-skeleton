class CreateApplications < ActiveRecord::Migration
  def change
    create_table :applications do |t|
      t.string :identifier
    end
  end
end
