class HomeController < ApplicationController
  def index
  end

  def doortest
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
