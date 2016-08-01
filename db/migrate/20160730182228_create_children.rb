class CreateChildren < ActiveRecord::Migration
  def change
    create_table :children do |t|
      t.string :user_id
      t.string :first_name
      t.string :last_name
      t.string :child_id
      t.string :phone
      t.string :relation_type

      t.timestamps
    end
    add_index :children, :child_id
  end
end
