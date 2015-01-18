require 'test_helper'

class ScEventsControllerTest < ActionController::TestCase
  setup do
    @sc_event = sc_events(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:sc_events)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create sc_event" do
    assert_difference('ScEvent.count') do
      post :create, sc_event : {}
    end

    assert_redirected_to sc_event_path(assigns(:sc_event))
  end

  test "should show sc_event" do
    get :show, id : @sc_event
    assert_response :success
  end

  test "should get edit" do
    get :edit, id : @sc_event
    assert_response :success
  end

  test "should update sc_event" do
    patch :update, id : @sc_event, sc_event : {}
    assert_redirected_to sc_event_path(assigns(:sc_event))
  end

  test "should destroy sc_event" do
    assert_difference('ScEvent.count', -1) do
      delete :destroy, id : @sc_event
    end

    assert_redirected_to sc_events_path
  end
end
