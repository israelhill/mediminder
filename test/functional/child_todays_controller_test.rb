require 'test_helper'

class ChildTodaysControllerTest < ActionController::TestCase
  setup do
    @child_today = child_todays(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:child_todays)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create child_today" do
    assert_difference('ChildToday.count') do
      post :create, child_today: { child_id: @child_today.child_id, drug_name: @child_today.drug_name, has_taken_today: @child_today.has_taken_today, should_take_today: @child_today.should_take_today, user_id: @child_today.user_id }
    end

    assert_redirected_to child_today_path(assigns(:child_today))
  end

  test "should show child_today" do
    get :show, id: @child_today
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @child_today
    assert_response :success
  end

  test "should update child_today" do
    put :update, id: @child_today, child_today: { child_id: @child_today.child_id, drug_name: @child_today.drug_name, has_taken_today: @child_today.has_taken_today, should_take_today: @child_today.should_take_today, user_id: @child_today.user_id }
    assert_redirected_to child_today_path(assigns(:child_today))
  end

  test "should destroy child_today" do
    assert_difference('ChildToday.count', -1) do
      delete :destroy, id: @child_today
    end

    assert_redirected_to child_todays_path
  end
end
