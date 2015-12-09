class CreatePayloads < ActiveRecord::Migration
  def change
    create_table :payloads do |t|
      t.string :requestedAt
      t.integer :respondedIn
    end
  end
end