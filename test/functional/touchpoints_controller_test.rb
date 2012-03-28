require 'test_helper'

class TouchpointsControllerTest < ActionController::TestCase
  setup do
    @touchpoint = touchpoints(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:touchpoints)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create touchpoint" do
    assert_difference('Touchpoint.count') do
      post :create, :touchpoint => @touchpoint.attributes
    end

    assert_redirected_to touchpoint_path(assigns(:touchpoint))
  end

  test "should show touchpoint" do
    get :show, :id => @touchpoint.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @touchpoint.to_param
    assert_response :success
  end

  test "should update touchpoint" do
    put :update, :id => @touchpoint.to_param, :touchpoint => @touchpoint.attributes
    assert_redirected_to touchpoint_path(assigns(:touchpoint))
  end

  test "should destroy touchpoint" do
    assert_difference('Touchpoint.count', -1) do
      delete :destroy, :id => @touchpoint.to_param
    end

    assert_redirected_to touchpoints_path
  end
end
