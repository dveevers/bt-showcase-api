require 'rails_helper'

RSpec.describe StatisticsController, type: :controller do

  describe "GET #keywords" do
    it "returns http success" do
      get :keywords
      expect(response).to have_http_status(:success)
    end
  end

end
