class OauthController < ApplicationController

  def callback
    post_params = {
      client_id: CONFIG.slack.key,
      client_secret: CONFIG.slack.secret,
      code: slack_params[:code],
      redirect_uri: "http://gifly.dented.io/oauth/slack/callback" #request.original_url.split('?')[0]
    }
    response = JSON.parse(RestClient.post(CONFIG.slack.access_token_url, post_params))
    Rails.logger.error("Slack Response #{response.inspect}")
    if(response['ok'])
      update_team_attributes = {
        name: response['team_name'],
        scope: response['scope'],
        code: slack_params[:code],
        channel_id: response['incoming_webhook']['channel'],
        configuration_url: response['incoming_webhook']['configuration_url'],
        webhook_url: response['incoming_webhook']['url']
      }
      team = Team.where(access_token: response['access_token'].to_s).first_or_create!(update_team_attributes)
      render_success_response(serialize_team(team))
    else
      render_failure_response(response['error'])
    end
  end

  private

  def serialize_team team
    ActiveModelSerializerHelper.serializer(team)
  end

  def slack_params
    params.permit(:id, :code, :state)
  end

end
