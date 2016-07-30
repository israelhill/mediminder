class ChildDrug < ActiveRecord::Base
  attr_accessible :amount_left, :child_id, :dosage, :drug_name, :end_time, :frequency, :start_time, :user_id
end
