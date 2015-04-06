require 'test_helper'

class DebugRunsControllerTest < ActionController::TestCase
  setup do
    @debug_run = debug_runs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:debug_runs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create debug_run" do
    assert_difference('DebugRun.count') do
      post :create, debug_run: { code_id: @debug_run.code_id, has_error: @debug_run.has_error, input: @debug_run.input, output: @debug_run.output, post_state: @debug_run.post_state, pre_state: @debug_run.pre_state, user_id: @debug_run.user_id }
    end

    assert_redirected_to debug_run_path(assigns(:debug_run))
  end

  test "should show debug_run" do
    get :show, id: @debug_run
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @debug_run
    assert_response :success
  end

  test "should update debug_run" do
    patch :update, id: @debug_run, debug_run: { code_id: @debug_run.code_id, has_error: @debug_run.has_error, input: @debug_run.input, output: @debug_run.output, post_state: @debug_run.post_state, pre_state: @debug_run.pre_state, user_id: @debug_run.user_id }
    assert_redirected_to debug_run_path(assigns(:debug_run))
  end

  test "should destroy debug_run" do
    assert_difference('DebugRun.count', -1) do
      delete :destroy, id: @debug_run
    end

    assert_redirected_to debug_runs_path
  end
end
