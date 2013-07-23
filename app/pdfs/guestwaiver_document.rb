class GuestwaiverDocument < Prawn::Document
  def initialize
    super
    template = "./static/HIVE13.liability.waver_.form_.2011.10.01.pdf"
    text "Welcome to the Hive!"
  end
end
