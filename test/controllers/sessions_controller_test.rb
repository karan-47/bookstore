require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
  end
  test "should get new" do
    get '/login'
    assert_response :success
  end

  test "should get create" do
    post '/login', params: { user: { username: @user.username, password: '1234' } }
    assert_response :success
  end

  test "should get destroy" do
    get '/logout'
    assert_redirected_to root_path
    assert_nil session[:user_id]
    # assert_response :success
  end

end
