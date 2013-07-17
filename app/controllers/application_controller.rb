class ApplicationController < ActionController::Base
  protect_from_forgery

  def monitor_message(msg)
    AMQP::Utilities::EventLoopHelper.run do
      AMQP.start
      AMQP.channel.direct("").publish(msg, routing_key: "amqpgem.rails.monitor")
    end
  end

  def current_user
    current_member
  end

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end

end
