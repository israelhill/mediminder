class CreateDrugInfos < ActiveRecord::Migration
  def change
    create_table :drug_infos do |t|
      t.string :drug_name
      t.string :side_effects

      t.timestamps
    end
  end
end
