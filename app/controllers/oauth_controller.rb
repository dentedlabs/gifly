class OauthController < ApplicationController

  def callback
    Rails.logger.error("Headers: #{request.headers.inspect}")
    @team = Team.upsert(uid: env["omniauth.auth"].to_s)
    params = {
      client_id: CONFIG.slack.key,
      client_secret: CONFIG.slack.secret,
      code: slack_params[:code],
      redirect_uri: 'hi'
    }
    response = RestClient.post(CONFIG.access_token_url, params: params)
    @team.update_attributes({ access_token: response['access_token'], scope: response['scope'], channel_id: response['channel_id'] })
  end

  def authroize
  end

  private

  def slack_params
    params.permit(:code, :state)
  end

end
