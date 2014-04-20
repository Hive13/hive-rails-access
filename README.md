hive-rails-access
=================

Ruby on Rails application for managing access and logging to the hive.


Requirements
------------

1. Redis server (redis.io) for backgrounding of sidekiq jobs 
2. Unicorn stack.
3. NGINX for HTTP calls.

Development
-----------

I've tried to make this as easy as humanly possible to get up to speed for
development work.  I do need to add some tests and some code coverage tools
in order to give y'all better feedback when you're doing something wrong, but
generally speaking, if you want to get started developing this application, you
can clone the repository, run 'bundle install' and start moving.  I've included
a vagrant file that should get most everything up and running (Postgresql, 
nginx, unicorn, rabbitmq, source code, and schemas in a ready-to-run bundle).

1. git clone this repo
2. add precise32 box to vagrant if you haven't already done so
3. bundle install (for local development)
4. visit either localhost:3000 or vagrantbox:80 
5. winning


Starting the Server
-------------------

Sometimes when the server starts, the unicorn process hangs because postgresql 
isn't attached.  Generally speaking, I try to start unicorn in a screen terminal
(as root) so that it's easier to troubleshoot.


