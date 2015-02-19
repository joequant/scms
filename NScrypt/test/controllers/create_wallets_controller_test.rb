require 'test_helper'

class CreateWalletsControllerTest < ActionController::TestCase
  setup do
    @create_wallet = create_wallets(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:create_wallets)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create create_wallet" do
    assert_difference('CreateWallet.count') do
      post :create, create_wallet: { address: @create_wallet.address, currency: @create_wallet.currency, user_id: @create_wallet.user_id }
    end

    assert_redirected_to create_wallet_path(assigns(:create_wallet))
  end

  test "should show create_wallet" do
    get :show, id: @create_wallet
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @create_wallet
    assert_response :success
  end

  test "should update create_wallet" do
    patch :update, id: @create_wallet, create_wallet: { address: @create_wallet.address, currency: @create_wallet.currency, user_id: @create_wallet.user_id }
    assert_redirected_to create_wallet_path(assigns(:create_wallet))
  end

  test "should destroy create_wallet" do
    assert_difference('CreateWallet.count', -1) do
      delete :destroy, id: @create_wallet
    end

    assert_redirected_to create_wallets_path
  end
end
