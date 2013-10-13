class HomeController < ApplicationController
  def index
  end

  def doortest
      render :text => "OK"
  end

  def vendtest
      render :text => "OK"
  end

  def testtest
      render :text => "OK"
  end
  
  def fsqsave
    auth = request.env["omniauth.auth"]
    token = params["code"]

    param = {}
    param["client_id"] = 'O1OPS1LVEPX0AI1HSQORSPQGHZSB4GXZ4CAM2YTCJ4MMSR55'
    param["client_secret"] = 'DKC50ZFPZLLB5BFVHDODCATPNHFIPZTJ3RTNP4L3RTPDRQLH'
    param["grant_type"] = "authorization_code"
    param["redirect_uri"] = 'http://localhost:3000/'
    param["code"] = token
    fsqurl = "https://foursquare.com/oauth2/access_token?#{param.to_query}"
    response = JSON.parse(Typhoeus::Request.get(fsqurl).body)
    current_member.fsqtoken = response["access_token"]
    current_member.save
    redirect_to root_url, :notice => "Added Foursquare Token!"
  end

  def statusboard
    @members = Member.all
    @guests = Guest.all
  end

end
