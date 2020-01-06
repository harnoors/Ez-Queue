require 'test_helper'

class ModeratorTest < ActiveSupport::TestCase
  def setup
    @mod = Moderator.new(name: "moderator", accessCode: "xxxxxx")
  end

  test "moderator should not be inserted unless room with accessCode exists" do
    assert_not @mod.valid?
  end

  test "mod should be valid" do
    Room.create(accessCode: "xxxxxx", password: "xxx")
    assert @mod.valid?
  end


  test "name should be present" do
    @mod.name = "    "
    assert_not @mod.valid?
  end

  test "accessCode should be present" do
    @mod.accessCode = "    "
    assert_not @mod.valid?
  end

  test "accessCode shouldn't be less than 6 characters long" do
    @mod.accessCode = "x" * 5
    assert_not @mod.valid?
  end

  test "accessCode shouldn't be more than 6 characters long" do
    @mod.accessCode = "x" * 7
    assert_not @mod.valid?
  end

  test "name shouldn't be more than 50 characters long" do
    @mod.name = "a" * 51
    assert_not @mod.valid?
  end

  test" name (key) should be unique" do
    duplicate_mod = @mod.dup
    @mod.save
    assert_not duplicate_mod.valid?
  end
end
