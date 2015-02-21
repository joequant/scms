require 'test_helper'

class ScValuesControllerTest < ActionController::TestCase
  setup do
    @sc_value = sc_values(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:sc_values)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create sc_value" do
    assert_difference('ScValue.count') do
      post :create, sc_value: { contract_id: @sc_value.contract_id, key: @sc_value.key, value: @sc_value.value }
    end

    assert_redirected_to sc_value_path(assigns(:sc_value))
  end

  test "should show sc_value" do
    get :show, id: @sc_value
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @sc_value
    assert_response :success
  end

  test "should update sc_value" do
    patch :update, id: @sc_value, sc_value: { contract_id: @sc_value.contract_id, key: @sc_value.key, value: @sc_value.value }
    assert_redirected_to sc_value_path(assigns(:sc_value))
  end

  test "should destroy sc_value" do
    assert_difference('ScValue.count', -1) do
      delete :destroy, id: @sc_value
    end

    assert_redirected_to sc_values_path
  end
end
