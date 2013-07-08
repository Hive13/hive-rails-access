class ApplicationController < ActionController::Base
  protect_from_forgery

  def monitor_message(msg)
    AMQP::Utilities::EventLoopHelper.run do
      AMQP.start
      AMQP.channel.direct("").publish(msg, routing_key: "amqpgem.rails.monitor")
    end
  end

end
