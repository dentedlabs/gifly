# WebMock.allow_net_connect!
class SearchController < ApplicationController

  def index
    Rails.logger.error("Slack #{params.inspect}")
    # if query_params[:token] != CONFIG.slack_token

    # options = {
    #   channel_id: query_params[:channel_id],
    #   token: query_params[:token],
    #   text: query_params[:text],
    #   data: serialize_gif(gif)
    # }
    # send(options)

    # else
    #   render_failure_response("404", 404)
    # end

    gifs = Gif.where(:tags.include => sanitize_query_text)
    gif = gifs.any? ? gifs.first : Gif.sample
    render_success_response(serialize_gif(gif))
  end

  private

  # def send(opts)
  #   url = 'https://slack.com/api/chat.postMessage'
  #   options = {
  #     token: 'xoxp-4611793306-4611793322-9779036039-d68116',
  #     channel: opts['channel_id'],
  #     text: opts['text'],
  #     attachments: [opts['data']],
  #     as_user: true
  #   }
  #   Rails.logger.error("Starting send #{options.inspect}")
  #   begin
  #     RestClient.post(url, options)
  #   rescue Exception => e
  #     Rails.logger.error("Failed Post: #{e}")
  #   end
  # end

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
