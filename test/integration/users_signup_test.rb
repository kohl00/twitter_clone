require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  test "invalid submissions aren't saved" do
  	get signup_path
  	assert_no_difference "User.count" do
  		post users_path, user: {name: " ",
  							email: "user@invalid",
  							password: 		"foo",
  							password_confirmation: "bar"}

  	end
  	assert_template 'users/new'
    assert_select "div#error_explanation" do
    assert_select "li", 4
    end
    assert_select 'div.field_with_errors'
  end

  test "valid signup information" do
    get signup_path
    assert_difference "User.count", 1 do 
      post_via_redirect users_path, user: {name: "Example User",
                                            email: "user@example.com",
                                            password:            "password",
                                            password_confirmation: "password"}
   end
    assert_template 'users/show'
    assert_not flash.nil?
    assert_select "div.alert-success", "Welcome to the Sample App!"
  end
end