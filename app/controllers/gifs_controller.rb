class GifsController < ApplicationController
  before_action :set_gif, only: [:show]

  def index
    gifs = Gif.all.page(params[:page])
    paging = get_paging(gifs)
    render_success_response(serialize_gifs(gifs), {links: paging})
  end

  def show
    if @gif
      render_success_response(serialize_gif(@gif))
    else
      render_bad_request_response
    end
  end

  private

  def serialize_gifs gifs
    ActiveModelSerializerHelper.array_serializer(gifs)
  end

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
