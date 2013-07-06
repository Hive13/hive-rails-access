class HomeController < ApplicationController
  def index
  end

  def doortest
      render :text => "OK"
  end
end
