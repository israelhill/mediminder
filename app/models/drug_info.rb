class DrugInfo < ActiveRecord::Base
  attr_accessible :drug_name, :side_effects
end
