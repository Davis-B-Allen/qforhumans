require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get root_path
    assert_response :success
  end

  test "should get cards" do
    get cards_path
    assert_response :success
  end

  test "should get about" do
    get about_path
    assert_response :success
  end
end
