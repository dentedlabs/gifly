require 'rails_helper'

RSpec.describe OauthController, type: :controller do

  describe "GET #authroize" do
    it "returns http success" do
      get :authroize
      expect(response).to have_http_status(:success)
    end
  end

end
