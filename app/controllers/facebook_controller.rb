class FacebookController < ApplicationController
  def setup
    request.env['omniauth.strategy'].options[:scope] = session[:fb_permissions]
    render :text => "Setup complete.", :status => 404
  end
end
