require 'test_helper'

class GamesControllerTest < ActionDispatch::IntegrationTest
  test "should get who_am_i" do
    get games_who_am_i_url
    assert_response :success
  end

end
