require 'test_helper'

class LensControllerTest < ActionController::TestCase
  setup do
    @len = lens(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:lens)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create len" do
    assert_difference('Len.count') do
      post :create, len: { name: @len.name }
    end

    assert_redirected_to len_path(assigns(:len))
  end

  test "should show len" do
    get :show, id: @len
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @len
    assert_response :success
  end

  test "should update len" do
    patch :update, id: @len, len: { name: @len.name }
    assert_redirected_to len_path(assigns(:len))
  end

  test "should destroy len" do
    assert_difference('Len.count', -1) do
      delete :destroy, id: @len
    end

    assert_redirected_to lens_path
  end
end
