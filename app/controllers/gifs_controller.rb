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

  def search
    Rails.logger.error("Slack #{params.inspect}")
    if query_params[:token] != CONFIG.slack_token
      gifs = Gif.where(:tags.include => query_params[:text])
      gif = gifs.any? ? gifs.first : Gif.sample
      render_success_response(serialize_gif(gif))
    else
      render_failure_response("404", 404)
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

  def query_params
    params.permit(:token, :team_id, :team_domain, :channel_id, :channel_name, :user_id, :user_name, :command, :text)
  end

end
