require 'test_helper'

class ContractsControllerTest < ActionController::TestCase
  setup do
    @contract = contracts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:contracts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create contract" do
    assert_difference('Contract.count') do
      post :create, contract : {description : @contract.description, title : @contract.title}
    end

    assert_redirected_to contract_path(assigns(:contract))
  end

  test "should show contract" do
    get :show, id : @contract
    assert_response :success
  end

  test "should get edit" do
    get :edit, id : @contract
    assert_response :success
  end

  test "should update contract" do
    patch :update, id : @contract, contract : {description : @contract.description, title : @contract.title}
    assert_redirected_to contract_path(assigns(:contract))
  end

  test "should destroy contract" do
    assert_difference('Contract.count', -1) do
      delete :destroy, id : @contract
    end

    assert_redirected_to contracts_path
  end
end
