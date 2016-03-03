require 'test_helper'

class UserTest < ActiveSupport::TestCase

  test "Find user from Github Data" do
  	github_data = Hash[ 
  					:uid => 123515214, 
  					'extra' => Hash[
  						'raw_info' => Hash[	
  							'name' => 'tets', 
  							'email' => 'tets@gmial.com', 
  							'login' => 'tets']
  					] 
  				]

    user = User.find_or_create_by_github_uid(github_data)

    assert_equal github_data['extra']['raw_info']['name'], user.name, "User name didn't match"
    assert_equal github_data['extra']['raw_info']['email'], user.email, "User email didn't match"
    assert_equal github_data['extra']['raw_info']['login'], user.display_name, "User display_name didn't match"
  end
end
