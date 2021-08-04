require "rails_helper"

RSpec.describe "Homes", type: :request do
  describe "GET /" do
    it "shows top page" do
      get root_path
      expect(response).to have_http_status(200)
    end
  end
end
