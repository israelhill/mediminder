require 'json'
require 'active_record'

# Controller and action definition for uri say/hello
# See routing configuration in config/routes.rb
class FormsController < ApplicationController

  def user
    # use params[:name] to get request parameter value by name
    # @parameter = params[:name]
    render partial: 'forms/user'
  end

  def form_data
    puts params
    user_object = params[:user]
    child_object = params[:child]
    drug1 = params[:drug1]
    drug2 = params[:drug2]
    drug3 = params[:drug3]


    user = User.find_all_by_first_name user_object[:userFirstName]
    puts 'The match: ' + user.first.to_s
    puts user.first.read_attribute('user_id').to_s

    user_id = user.first.read_attribute('user_id').to_s
    # User.update(user[:id], phone: user_object[:userPhone], email: user_object[:userEmail])
    @child = Child.new(user_id: user.first.read_attribute('user_id').to_s, first_name: child_object[:childFirstName],
              last_name: child_object[:childLastName], phone: child_object[:childPhone], relation_type: child_object[:relationType])
    @child.save

    @drug1 = ChildDrug.new(user_id: user_id, child_id: @child.read_attribute('id'), drug_name: drug1[:drug_name],
                           dosage: drug1[:drug_dosage], frequency: drug1[:drug_freq])
    @drug1.save

    @drug2 = ChildDrug.new(user_id: user_id, child_id: @child.read_attribute('id'), drug_name: drug2[:drug_name],
                           dosage: drug2[:drug_dosage], frequency: drug2[:drug_freq])
    @drug2.save

    @drug3 = ChildDrug.new(user_id: user_id, child_id: @child.read_attribute('id'), drug_name: drug3[:drug_name],
                           dosage: drug3[:drug_dosage], frequency: drug3[:drug_freq])
    @drug3.save
    render nothing: true
  end
end