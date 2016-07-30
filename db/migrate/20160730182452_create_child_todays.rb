class CreateChildTodays < ActiveRecord::Migration
  def change
    create_table :child_todays do |t|
      t.integer :user_id
      t.integer :child_id
      t.string :drug_name
      t.boolean :should_take_today
      t.boolean :has_taken_today

      t.timestamps
    end
  end
end
