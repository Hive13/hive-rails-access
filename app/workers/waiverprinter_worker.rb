class WaiverprinterWorker
  include Sidekiq::Worker
  sidekiq_options queue: "print"
# sidekiq_options retry: false


  def perform(memberId)
    guest = Guest.find(memberId)
    # Logic to print the badge goes here.
    pdf = Prawn::Document.new(:template => Rails.root.to_s + "/public/static/HIVE13.liability.waver_.form_.2011.10.01.pdf")
    pdf.text_box "#{guest.fname} #{guest.lname}", :at => [140,513]
    pdf.text_box "#{guest.fname} #{guest.lname} (#{guest.id})", :at => [200,12]

    pdf.bounding_box [200,13], :width => 100 do
      barcode = Barby::Code128B.new("#{guest.strHash}")
      barcode.annotate_pdf(pdf, :height => 30)
    end

    pdf.render_file "/tmp/waiver#{guest.fname}#{guest.lname}.pdf"
    exec ""

  end
end