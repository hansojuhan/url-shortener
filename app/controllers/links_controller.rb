class LinksController < ApplicationController
  before_action :set_link, only: [:show, :edit, :update, :destroy]
  before_action :check_if_editable, only: [:edit, :update, :destroy]

  def index
    @pagy, @links = pagy Link.recent_first

    # If link already defined, let's skip it
    @link ||= Link.new
    
  rescue Pagy::OverflowError
    redirect_to root_path
  end

  def create
    # Add in the current user to the link params
    @link = Link.new(link_params.with_defaults(user: current_user))

    if @link.save
      respond_to do |format|

        format.turbo_stream { render turbo_stream: [
          turbo_stream.prepend("links", @link)]
        }

        # OPTION 1
        # format.turbo_stream { render turbo_stream: [
        #   turbo_stream.prepend("links", @link),
        #   turbo_stream.replace("link_form", partial: "links/form", locals: { link: Link.new })]
        # }

        format.html { redirect_to root_path }
      end
    else
      index # call the index method. As long as it does not render/redirect
      render :index, status: :unprocessable_entity # http status code for error
    end
  end
  
  def edit
  end

  def update
    if @link.update(link_params)
      redirect_to @link
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @link.destroy
    redirect_to root_path, notice: "Link has been deleted."
  end

  private
  def link_params
    params.require(:link).permit(:url)
  end

  def check_if_editable
    unless @link.editable_by?(current_user)
      redirect_to @link, alert: "You aren't allowed to do that."
    end
  end
end