class CreateReferrerTable < ActiveRecord::Migration
  def change
    create_table :referrers do |t|
      t.string :referrer
    end
  end
end
