require 'test_helper'

class UsersControllerTest < ActionController::TestCase

	def setup
		@user = users(:kohl)
		@other_user = users(:archer)
	end
  	
  	test "should get new" do
    	get :new
    	assert_response :success
  	end

    test "should redirect index when not logged in" do
      get :index
      assert_redirected_to login_url
    end

  	#logged_in_user. Uses multiple fixtures
  	test "should redirect edit when not logged in" do
  		get :edit, id: @user
  		assert_redirected_to login_url
  	end

  	#logged_in_user. Uses multiple fixtures
  	test "should redirect update when not logged in" do
  		patch :update, id: @user, user: {name: @user.name, email: @user.email }
  		assert_redirected_to login_url 
  	end

  	#correct_user. Uses multiple fixtures
  	test "should redirect edit when logged in as wrong user" do
  		log_in_as(@other_user)
  		get :edit, id: @user
  		assert_redirected_to root_url
  	end

  	#correct_user. Uses mutliple fixtures
  	test "should redirect update when logged in as wrong user" do
  		log_in_as(@other_user)
  		patch :update, id: @user, user: {name: @user.name, email: @user.email }
  		assert_redirected_to root_url
  	end

    test "should redirect destroy when logged in as a non-admin" do
      log_in_as(@other_user)
      assert_no_difference "User.count" do
        delete :destroy, id: @user
      end
      assert_redirected_to root_url
    end

    test "should redirect destroy when not logged in" do
      assert_no_difference 'User.count' do
        delete :destroy, id: @user
      end
      assert_redirected_to login_url
    end

end
