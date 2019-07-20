require 'test_helper'

class RegisterMailerTest < ActionMailer::TestCase
  test "register_account" do
    mail = RegisterMailer.register_account
    assert_equal "Register account", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
