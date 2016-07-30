class ChildToday < ActiveRecord::Base
  attr_accessible :child_id, :drug_name, :has_taken_today, :should_take_today, :user_id
end
