require 'test_helper'

class RoomsCreateroomTest < ActionDispatch::IntegrationTest
 
  test "invalid (empty) password entered" do
    get createroom_path
    assert_no_difference 'Room.count' do
      post rooms_path, params: { room: { accessCode: "xxxxx", password: "  "} }
    end
    assert_template 'rooms/new'
  end

  test "valid (non_empty) password entered" do
    get createroom_path
    assert_difference 'Room.count', 1 do
      post rooms_path, params: { room: { accessCode: "xxxxxx", password: "password"} }
    end
    follow_redirect!
    assert_template 'rooms/show'
  end

end
