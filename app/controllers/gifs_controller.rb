class GifsController < ApplicationController
  before_action :set_gif, only: [:show]

  def index
    gifs = Gif.where(:tags.include => params[:text])
    gif = gifs.any? ? gifs.first : Gif.sample
    render_success_response(serialize_gif(gif))
  end

  def show
    if @gif
      render_success_response(serialize_gif(@gif))
    else
      render_bad_request_response
    end
  end

  private

  def serialize_gif gif
    ActiveModelSerializerHelper.serializer(gif)
  end

  def set_gif
    @gif = Gif.find(find_params[:id])
  end

  def find_params
    params.permit(:id)
  end

end
