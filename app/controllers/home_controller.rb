class HomeController < ApplicationController
  def index
  end

  def doortest
      monitor_message("[PORTAL][WARN] Door Controller was reset.  New IP address is: #{request.env['HTTP_X_FORWARDED_FOR']}")
      render :text => "OK"
  end
  
  def fsqsave
    auth = request.env["omniauth.auth"]
    token = params["code"]
    current_member.fsqtoken = token
    current_member.save
    redirect_to root_url, :notice => "Added Foursquare Token!"
  end
  
end
