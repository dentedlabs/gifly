require 'rails_helper'

RSpec.describe OauthController, type: :controller do

  describe "GET #authroize" do
    it "returns http success" do
      get :authroize
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #callback" do
    it "returns error if no code present" do
      # stub_request(:post, "https://slack.com/api/oauth.access").
      # with(:body => {"params"=>{"client_id"=>"4611793306.10070057840", "client_secret"=>"0e0c6e028ee6a8e357d216d6d6c73032", "code"=>"4611793306.10118993746.65887fb862", "redirect_uri"=>"http://localhost:3000/oauth/slack/callback?code=4611793306.10118993746.65887fb862&state="}},
      #      :headers => {'Accept'=>'*/*; q=0.5, application/xml', 'Accept-Encoding'=>'gzip, deflate', 'Content-Length'=>'274', 'Content-Type'=>'application/x-www-form-urlencoded', 'User-Agent'=>'Ruby'}).
      # to_return(:status => 200, :body => "", :headers => {})
    end
  end

end
