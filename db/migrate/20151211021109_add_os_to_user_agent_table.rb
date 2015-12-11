class AddOsToUserAgentTable < ActiveRecord::Migration
  def change
    add_column :user_agents, :os, :string
  end
end
