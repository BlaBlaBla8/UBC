class ApplicationMailer < ActionMailer::Base
  default from: 'p.leonid1094@gmail.com'
  layout 'mailer'

 def send_test_email
   mail to: 'p.leonid1094@gmail.com', :subject => 'lal'
 end
end
