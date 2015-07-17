# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview
	UserMailer.welcome_email(User.create(email: 'testman@coo.com', name: 'Bob'))
end
