class BadgeprinterWorker
  include Sidekiq::Worker
  sidekiq_options queue: "print"
# sidekiq_options retry: false


  def perform(memberId)
    # Logic to print the badge goes here.
    pdf = Prawn::Document.new
    pdf.text "Welcome to Hive13!"
    file = pdf.render_file

  end
end