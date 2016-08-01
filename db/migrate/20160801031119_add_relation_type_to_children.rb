class AddRelationTypeToChildren < ActiveRecord::Migration
  def change
    add_column :children, :relation_type, :string
  end
end
