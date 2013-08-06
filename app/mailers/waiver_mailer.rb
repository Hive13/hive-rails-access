class WaiverMailer < ActionMailer::Base
  def welcome_email(guest)
    @guest = guest
    attachments['Hive13_Liability_Waiver.pdf'] = File.read(Rails.root.to_s + "/public/static/HIVE13.liability.waver_.form_.2011.10.01.pdf")
    mail(to: @guest.email,
         subject: "Welcome to Hive13, #{@guest.fname}", :from => 'rt@hive13.org')
  end
end
