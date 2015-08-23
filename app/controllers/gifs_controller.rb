class GifsController < ApplicationController

  def index
    gifs = Gif.where(:tags.include => params[:q])
    Rails.logger.error("Gifs, #{gifs.inspect}")
    if gifs.any?
      gif = gifs.first
    else
      gif = Gif.sample
    end
    Rails.logger.error("GIF #{gif.inspect}")
    render_success_response(serialize_gif(gif))
  end

  private

    def serialize_gif gif
      ActiveModelSerializerHelper.serializer(gif)
    end

end
