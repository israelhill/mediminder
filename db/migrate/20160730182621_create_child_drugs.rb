class CreateChildDrugs < ActiveRecord::Migration
  def change
    create_table :child_drugs do |t|
      t.string :user_id
      t.integer :child_id
      t.string :drug_name
      t.string :amount_left
      t.time :start_time
      t.time :end_time
      t.integer :dosage
      t.string :frequency

      t.timestamps
    end
  end
end
