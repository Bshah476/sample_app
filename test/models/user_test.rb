require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: "Example Name", email: "Example@email.com")
  end
  
  test "should be valid" do
    assert @user.valid?
  end
  
  test "should have name" do
    @user.name = "   "
    assert !(@user.valid?)
  end
  
  test "should have email" do
    @user.email = "  "
    assert !(@user.valid?)
  end
  
  test "should not have long name" do
    @user.name = "a" * 51
    assert !(@user.valid?)
  end
  
  test "should not have long email" do
    @user.email = "a" * 244 + "@example.com"
    assert !(@user.valid?)
  end
  
  test "email validation should accept valid addresses" do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid"
    end
  end

  test "email validation should reject invalid addresses" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end

    
  
end
