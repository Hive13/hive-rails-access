require 'amqp/utilities/event_loop_helper'
require 'amqp/integration/rails'
 
module AMQPManager
  def self.start
    AMQP::Utilities::EventLoopHelper.run
    AMQP::Integration::Rails.start do |connection|
      connection.on_error do |ch, connection_close|
        raise connection_close.reply_text
      end
 
      connection.on_tcp_connection_loss do |conn, settings|
        conn.reconnect(false, 2)
      end
 
      connection.on_tcp_connection_failure do |conn, settings|
        conn.reconnect(false, 2)
      end
 
      channel = AMQP::Channel.new(connection, AMQP::Channel.next_channel_id, :auto_recovery => true)
      channel.on_error do |ch, channel_close|
        raise channel_close.reply_text
      end
 
      AMQP.channel = channel
    end
  end
end
 
AMQPManager.start unless ENV["UNICORN"]
