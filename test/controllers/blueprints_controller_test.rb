require "test_helper"

class BlueprintsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @blueprint = blueprints(:one)
  end

  test "should get index" do
    get blueprints_url
    assert_response :success
  end

  test "should get new" do
    get new_blueprint_url
    assert_response :success
  end

  test "should create blueprint" do
    assert_difference("Blueprint.count") do
      post blueprints_url, params: { blueprint: {  } }
    end

    assert_redirected_to blueprint_url(Blueprint.last)
  end

  test "should show blueprint" do
    get blueprint_url(@blueprint)
    assert_response :success
  end

  test "should get edit" do
    get edit_blueprint_url(@blueprint)
    assert_response :success
  end

  test "should update blueprint" do
    patch blueprint_url(@blueprint), params: { blueprint: {  } }
    assert_redirected_to blueprint_url(@blueprint)
  end

  test "should destroy blueprint" do
    assert_difference("Blueprint.count", -1) do
      delete blueprint_url(@blueprint)
    end

    assert_redirected_to blueprints_url
  end
end
