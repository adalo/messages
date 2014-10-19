class AddSubscriptionLimitToSubscriptions < ActiveRecord::Migration
  def change
    add_column :subscriptions, :subscription_limit, :integer
  end
end
