class ReceiptMailer < ActionMailer::Base
  def welcome_email(member)
    @member = Member.find(member)

    mail(to: @member.email,
         subject: "Receipt for Hive13 Soda Purchase", :from => 'hive13help@gmail.com')
  end
end
