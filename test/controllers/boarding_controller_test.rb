require 'test_helper'

class BoardingControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get boarding_index_url
    assert_response :success
  end

end
