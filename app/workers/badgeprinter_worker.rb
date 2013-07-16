class BadgeprinterWorker
  include Sidekiq::Worker
  sidekiq_options queue: "print"
# sidekiq_options retry: false


  def perform(memberId)
    # Logic to print the badge goes here.

  end
end