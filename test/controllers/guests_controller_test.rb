require 'test_helper'

class GuestsControllerTest < ActionDispatch::IntegrationTest
   test "should get new" do
     get join_path
     assert_response :success
   end
end
