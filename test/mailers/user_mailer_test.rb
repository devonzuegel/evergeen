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


  test "password_reset" do
    user = users(:michael)

    # Need to create a password reset token for use in the views; unlike
    # the activation token, which is created for every user by a before_create
    # callback, the password reset token is created only when a user 
    # successfully submits the “forgot password” form. This will occur
    # naturally in an integration test, but in the present context we need to
    # run create_reset_digest by hand.
    user.reset_token = User.new_token

    mail = UserMailer.password_reset(user)
    
    assert_equal "Password reset", mail.subject
    assert_equal [user.email], mail.to
    assert_equal ["noreply@example.com"], mail.from

    assert_match user.reset_token,        mail.body.encoded
    assert_match CGI::escape(user.email), mail.body.encoded
  end

end