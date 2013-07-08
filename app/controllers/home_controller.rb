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

    # Apparently, I'm not done here.  I can't just take this token and do things with it.  Apparently, Omniauth only
    # does a half-assed job of grabbing a token.  Shame on you, omniauth...
    # RNK2EUTWFUMTWXR1GOFZUFHLMZYJXVCNGIT1ZHF2H5MQ4VZN
    # Turns into this Piece of shit...
    # https://foursquare.com/oauth2/access_token?client_id=O1OPS1LVEPX0AI1HSQORSPQGHZSB4GXZ4CAM2YTCJ4MMSR55&client_secret=DKC50ZFPZLLB5BFVHDODCATPNHFIPZTJ3RTNP4L3RTPDRQLH&grant_type=authorization_code&redirect_uri=http%3A%2F%2Fdevops.ewscloud.com%3A8080%2Ffqredirect%2F&code=RNK2EUTWFUMTWXR1GOFZUFHLMZYJXVCNGIT1ZHF2H5MQ4VZN
    #
    # https://developer.foursquare.com/overview/auth

    current_member.fsqtoken = token
    current_member.save
    redirect_to root_url, :notice => "Added Foursquare Token!"
  end
  
end
