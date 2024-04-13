class LinksController < ApplicationController
  before_action :set_link, only: [:show, :edit, :update, :destroy]

  def index
    @links = Link.recent_first

    # If link already defined, let's skip it
    @link ||= Link.new
  end

  def create
    @link = Link.new(link_params)
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
end