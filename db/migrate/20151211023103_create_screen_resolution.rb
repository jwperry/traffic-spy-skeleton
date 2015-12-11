class CreateScreenResolution < ActiveRecord::Migration
  def change
    create_table :screen_resolutions do |t|
      t.integer :width
      t.integer :height
    end
  end
end
