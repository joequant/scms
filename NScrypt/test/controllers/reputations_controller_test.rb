require 'test_helper'

class ReputationsControllerTest < ActionController::TestCase
  setup do
    @reputation = reputations(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:reputations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create reputation" do
    assert_difference('Reputation.count') do
      post :create, reputation: { category: @reputation.category, contract_id: @reputation.contract_id, item: @reputation.item, params: @reputation.params, status: @reputation.status, subcategory: @reputation.subcategory, user_id: @reputation.user_id }
    end

    assert_redirected_to reputation_path(assigns(:reputation))
  end

  test "should show reputation" do
    get :show, id: @reputation
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @reputation
    assert_response :success
  end

  test "should update reputation" do
    patch :update, id: @reputation, reputation: { category: @reputation.category, contract_id: @reputation.contract_id, item: @reputation.item, params: @reputation.params, status: @reputation.status, subcategory: @reputation.subcategory, user_id: @reputation.user_id }
    assert_redirected_to reputation_path(assigns(:reputation))
  end

  test "should destroy reputation" do
    assert_difference('Reputation.count', -1) do
      delete :destroy, id: @reputation
    end

    assert_redirected_to reputations_path
  end
end
