class ChangeDataTypeForUserId < ActiveRecord::Migration
  def up
    change_column :child_todays, :user_id, :string
    change_column :child_drugs, :user_id, :string
  end

  def down
    change_column :child_todays, :user_id, :integer
    change_column :child_drugs, :user_id, :integer
  end
end
