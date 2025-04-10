class UserMailer < ApplicationMailer
  default from: 'no-reply@example.com'

  def report_violation_email(user, post)
    @user = user
    @post = post
    mail(to: @user.email, subject: "Violation Report: #{@post.title}")
  end
end
