require 'test_helper'

class GuestTest < ActiveSupport::TestCase
  def setup
    @guest = Guest.new(accessCode: "xxxxxx")
  end

  test "guest should not be inserted unless room with accessCode exists" do
    assert_not @guest.valid?
  end

  test "guest should be valid" do
    Room.create(accessCode: "xxxxxx", password: "xxx")
    assert @guest.valid?
  end

  test "accessCode should be present" do
    @guest.accessCode = "     "
    assert_not @guest.valid?
  end

  test "accessCode shouldn't be less than 6 characters long" do
    @guest.accessCode = "x" * 5
    assert_not @guest.valid?
  end

  test "accessCode shouldn't be more than 6 characters long" do
    @guest.accessCode = "x" * 7
    assert_not @guest.valid?
  end
end
