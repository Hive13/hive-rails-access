#!/usr/bin/env ruby
# encoding: utf-8
 
require "rubygems"
require "amqp"
require "cinch"
 
class RailsMonitor
  def initialize(bot)
    @bot = bot
    EventMachine.run do
      connection = AMQP.connect(:host => '127.0.0.1')
      puts "Connected to AMQP broker."
      channel  = AMQP::Channel.new(connection)
      queue    = channel.queue("amqpgem.rails.monitor", :durable => true)
      exchange = channel.direct("")
      queue.subscribe do |payload|
        self.msg("#{payload}")
      end
    end
  end
 
  def msg(msg)
    @bot.handlers.dispatch(:monitor_msg, nil, msg)
  end
end
 
class JoinPart
  include Cinch::Plugin
 
  match /join (.+)/, method: :join
  match /part(?: (.+))?/, method: :part
 
  def initialize(*args)
    super
    @admins = ["iwilson"]
  end
 
  def check_user(user)
    user.refresh
    @admins.include?(user.authname)
  end
 
  def join(m, channel)
    return unless check_user(m.user)
    Channel(channel).join
  end
 
  def part(m, channel)
    return unless check_user(m.user)
    channel ||= m.channel
    Channel(channel).part if channel
  end
end
 
class MonitorBot
  include Cinch::Plugin
 
  listen_to :monitor_msg
  def listen(m, msg)
    if msg.include? "[WARN]"
      Channel("#hive13").send Format(:red,"#{msg}")
    elsif msg.include? "[INFO]"
      Channel("#hive13").send Format(:green,"#{msg}")
    else
      Channel("#hive13").send "#{msg}"
    end
  end
end
 
bot = Cinch::Bot.new do
  configure do |c|
    c.nick            = "doormonitor"
    c.realname        = "Hive13 Door Monitor"
    c.user            = "hive13doormonitor"
    c.server          = "irc.freenode.org"
    #c.port            = 7000
    #c.ssl             = true
    c.channels        = ['#hive13']
    c.verbose         = true
    c.plugins.plugins = [MonitorBot,JoinPart]
  end
end
 
Thread.new { RailsMonitor.new(bot).start }
bot.start
