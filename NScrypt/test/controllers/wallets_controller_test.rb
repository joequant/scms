require 'test_helper'

class WalletsControllerTest < ActionController::TestCase
  setup do
    @wallet = wallets(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:wallets)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create wallet" do
    assert_difference('Wallet.count') do
      post :create, wallet: { address: @wallet.address, currency: @wallet.currency, user_id: @wallet.user_id }
    end

    assert_redirected_to wallet_path(assigns(:wallet))
  end

  test "should show wallet" do
    get :show, id: @wallet
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @wallet
    assert_response :success
  end

  test "should update wallet" do
    patch :update, id: @wallet, wallet: { address: @wallet.address, currency: @wallet.currency, user_id: @wallet.user_id }
    assert_redirected_to wallet_path(assigns(:wallet))
  end

  test "should destroy wallet" do
    assert_difference('Wallet.count', -1) do
      delete :destroy, id: @wallet
    end

    assert_redirected_to wallets_path
  end
end
