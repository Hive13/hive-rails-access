class WaiverMailer < ActionMailer::Base
  def welcome_email(guest)
    @guest = guest
    mail(to: @guest.email,
         subject: "Please see the Terms and Conditions attached", :from => 'rt@hive13.org')
  end
end
