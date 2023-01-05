class AddColumnsToNotifications < ActiveRecord::Migration[7.0]
  def change
    add_column :notifications, :message, :string, null: false
    change_column_null :notifications, :notifiable_type, false
    change_column_null :notifications, :notifiable_id, false
  end
end
