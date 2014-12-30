require 'test_helper'

class UserMailerTest < ActionMailer::TestCase

  test "account_activation" do
    user = users(:michael)
    ##
    # Adds an activation token to the fixture user, which would otherwise
    # be blank, b/c comes directly from db.
    user.activation_token = User.new_token

    mail = UserMailer.account_activation(user)

    assert_equal("Account activation", mail.subject)
    assert_equal([user.email], mail.to)
    assert_equal(["noreply@example.com"], mail.from)

    ##
    # Check that the name, activation token, and escaped email appear in
    # the email’s body.
    assert_match(user.name,               mail.body.encoded)
    assert_match(user.activation_token,   mail.body.encoded)
    assert_match(CGI::escape(user.email), mail.body.encoded)
  end

end