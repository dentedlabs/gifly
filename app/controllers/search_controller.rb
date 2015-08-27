class SearchController < ApplicationController

  def index
    Rails.logger.error("Slack #{params.inspect}")
    # if query_params[:token] != CONFIG.slack_token
    gifs = Gif.where(:tags.include => sanitize_query_text)
    gif = gifs.any? ? gifs.first : Gif.sample
    render_slack_success_response(serialize_gif(gif))
    # else
    #   render_failure_response("404", 404)
    # end
  end

  private

  def serialize_gif gif
    ActiveModelSerializerHelper.serializer(gif)
  end

  def sanitize_query_text
    query_params[:text].split(' ')
  end

  def query_params
    params.permit(:token, :team_id, :team_domain, :channel_id, :channel_name, :user_id, :user_name, :command, :text)
  end

end
