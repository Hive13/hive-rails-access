class CheckinWorker
  include Sidekiq::Worker
  sidekiq_options queue: "high"
  # sidekiq_options retry: false

  def perform(memberId)
    member = Member.find(memberId)
    unless member.fsqtoken.blank? || member.is_private == true
      fsqclient = Foursquare2::Client.new(:oauth_token => member.fsqtoken )
      fsqclient.search_venues(:ll => '39.13545607,-84.5385181903', :query => 'hive13')
      fsqclient.add_checkin(:venueId => "4b5140ecf964a520d54827e3", :broadcast => 'public', :ll => '39.13545607,-84.5385181903', :shout => 'Checked in via RFID Badge')
    end

    member.last_access = Time.now

    #Grab a copy of their picture as they walk into the hive
    member.picture_from_url 'http://shell.hive13.org/webcam1/fullsize.jpg'

    # Changed last timestamp to now...
    member.save
  end

end
