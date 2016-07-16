class WelcomeController < ApplicationController

  def hello_world
    render :layout => false
  end

end
