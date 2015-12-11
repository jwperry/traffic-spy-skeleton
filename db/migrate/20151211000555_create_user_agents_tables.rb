class CreateUserAgentsTables < ActiveRecord::Migration
  def change
    create_table :user_agents do |t|
      t.string :user_agent
    end
  end
end
