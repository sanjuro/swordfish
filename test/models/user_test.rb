require 'test_helper'

class UserTest < ActiveSupport::TestCase

  test "the truth" do
    assert true
  end

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
    assert user.valid?, 'User did not save'
  end
end
