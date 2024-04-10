class ViewsController < ApplicationController
  before_action :set_link

  def show
    # ! Throw error if couldn't 
    @link.views.create(
      ip: request.ip,
      user_agent: request.user_agent
    )
    
    redirect_to @link.url, allow_other_host: true # External link
  end
end