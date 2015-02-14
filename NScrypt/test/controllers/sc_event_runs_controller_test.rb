require 'test_helper'

class ScEventRunsControllerTest < ActionController::TestCase
  setup do
    @sc_event_run = sc_event_runs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:sc_event_runs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create sc_event_run" do
    assert_difference('ScEventRun.count') do
      post :create, sc_event_run: { result: @sc_event_run.result, run_at: @sc_event_run.run_at, sc_event_id: @sc_event_run.sc_event_id }
    end

    assert_redirected_to sc_event_run_path(assigns(:sc_event_run))
  end

  test "should show sc_event_run" do
    get :show, id: @sc_event_run
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @sc_event_run
    assert_response :success
  end

  test "should update sc_event_run" do
    patch :update, id: @sc_event_run, sc_event_run: { result: @sc_event_run.result, run_at: @sc_event_run.run_at, sc_event_id: @sc_event_run.sc_event_id }
    assert_redirected_to sc_event_run_path(assigns(:sc_event_run))
  end

  test "should destroy sc_event_run" do
    assert_difference('ScEventRun.count', -1) do
      delete :destroy, id: @sc_event_run
    end

    assert_redirected_to sc_event_runs_path
  end
end
