require 'test_helper'

class ChildDrugsControllerTest < ActionController::TestCase
  setup do
    @child_drug = child_drugs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:child_drugs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create child_drug" do
    assert_difference('ChildDrug.count') do
      post :create, child_drug: { amount_left: @child_drug.amount_left, child_id: @child_drug.child_id, dosage: @child_drug.dosage, drug_name: @child_drug.drug_name, end_time: @child_drug.end_time, frequency: @child_drug.frequency, start_time: @child_drug.start_time, user_id: @child_drug.user_id }
    end

    assert_redirected_to child_drug_path(assigns(:child_drug))
  end

  test "should show child_drug" do
    get :show, id: @child_drug
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @child_drug
    assert_response :success
  end

  test "should update child_drug" do
    put :update, id: @child_drug, child_drug: { amount_left: @child_drug.amount_left, child_id: @child_drug.child_id, dosage: @child_drug.dosage, drug_name: @child_drug.drug_name, end_time: @child_drug.end_time, frequency: @child_drug.frequency, start_time: @child_drug.start_time, user_id: @child_drug.user_id }
    assert_redirected_to child_drug_path(assigns(:child_drug))
  end

  test "should destroy child_drug" do
    assert_difference('ChildDrug.count', -1) do
      delete :destroy, id: @child_drug
    end

    assert_redirected_to child_drugs_path
  end
end
