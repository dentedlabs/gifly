require 'rails_helper'

RSpec.describe GifsController, type: :controller do
  context "GET #index" do
    # before do
    #   create_table(:gifs)
    # end
    #
    # after do
    #   drop_table(:gifs)
    # end

    describe "GET #index" do
      it "returns http success" do
        get :index
        expect(response).to have_http_status(:success)
      end
    end

  end
end
