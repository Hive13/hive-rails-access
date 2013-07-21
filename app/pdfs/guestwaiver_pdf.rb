class GuestwaiverPdf < Prawn::Document
  
  def initialize(guest)
    @guest = guest
    text "Text goes here."
  end
    
end