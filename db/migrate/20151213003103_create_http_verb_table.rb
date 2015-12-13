class CreateHttpVerbTable < ActiveRecord::Migration
  def change
    create_table :verbs do |t|
      t.string :verb
    end
  end
end
