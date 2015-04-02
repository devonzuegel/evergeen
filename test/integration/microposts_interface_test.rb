# require 'test_helper'

# class MicropostsInterfaceTest < ActionDispatch::IntegrationTest

#   def setup
#     @user = users(:michael)
#   end


#   ##
#   # Log in, check the micropost pagination, make an invalid submission,
#   # make a valid submission, delete a post, and then visit a second
#   # user’s page to make sure there are no “delete” links. 
#   test "micropost interface" do
#     log_in_as(@user)
#     get(root_path)
#     assert_select('div.pagination')

#     # Invalid submission
#     assert_no_difference 'Micropost.count' do
#       post(microposts_path, micropost: { content: "" })
#     end
#     assert_select('div#error_explanation')

#     # Valid submission
#     content = "This micropost really ties the room together"
#     assert_difference 'Micropost.count', 1 do
#       post(microposts_path, micropost: { content: content })
#     end
#     assert_redirected_to(root_url)

#     ##
#     # Uses post followed by follow_redirect! in place of the equivalent
#     # post_via_redirect in anticipation of the image upload test.
#     follow_redirect!
#     assert_match(content, response.body)

#     # Delete a post.
#     assert_select('a', text: 'delete')
#     first_micropost = @user.microposts.paginate(page: 1).first
#     assert_difference 'Micropost.count', -1 do
#       delete micropost_path(first_micropost)
#     end

#     # Visit a different user.
#     get(user_path(users(:archer)))
#     # Ensure that there aren't any available delete links
#     assert_select('a', text: 'delete', count: 0)
#   end

# end