class BadgeprinterWorker
  include Sidekiq::Worker
  sidekiq_options queue: "print"
# sidekiq_options retry: false


  def perform(memberId)
    # Logic to print the badge goes here.
    guest = Guest.find(memberId)
    pdf = Prawn::Document.new
    pdf.text "Welcome to Hive13, #{guest.fname}!"
    pdf.render_file "/tmp/badge#{guest.fname}#{guest.lname}.pdf"
    exec ""
  end
end