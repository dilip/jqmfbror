class WelcomeController < ApplicationController

  def index
    if signed_in?
      redirect_to :controller => :friends, :action => :index
      return
    end
  end

end
