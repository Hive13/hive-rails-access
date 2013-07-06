OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :foursquare, 'O1OPS1LVEPX0AI1HSQORSPQGHZSB4GXZ4CAM2YTCJ4MMSR55', 'DKC50ZFPZLLB5BFVHDODCATPNHFIPZTJ3RTNP4L3RTPDRQLH'
end