require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: "Example Name", email: "Example@email.com", password: "foobar", password_confirmation: "foobar")
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
  
  test "should accept valid addresses" do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid"
    end
  end

  test "should reject invalid addresses" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com foo@bar..com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end
  
  test "should reject duplicate emails" do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    assert !(duplicate_user.valid?)
  end
  
  test "should not have blank password" do
    @user.password = @user.password_confirmation = " " * 6
    assert !(@user.valid?)
  end
  
  test "should not have short password" do
    @user.password = @user.password_confirmation = "a" * 5
    assert !(@user.valid?)
  end
    
  
  

    
  
end
