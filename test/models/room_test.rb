require 'test_helper'

class RoomTest < ActiveSupport::TestCase
  def setup
    @room = Room.new(accessCode: "xxxxxx", password: "xxxxxx")
  end

  test "should be valid" do
    assert @room.valid?
  end

  test "accessCode should be present" do
    @room.accessCode = "    "
    assert_not @room.valid?
  end

  test "password should be present" do
    @room.password = "    "
    assert_not @room.valid?
  end

  test "accessCode shouldn't be less than 6 characters long" do
    @room.accessCode = "x" * 5
    assert_not @room.valid?
  end

  test "accessCode shouldn't be more than 6 characters long" do
    @room.accessCode = "x" * 7
    assert_not @room.valid?
  end

  test "accessCode (key) should be unique" do
    duplicate_room = @room.dup
    @room.save
    assert_not duplicate_room.valid?
  end
end
