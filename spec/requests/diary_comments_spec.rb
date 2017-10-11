require 'rails_helper'

RSpec.describe "DiaryComments", type: :request do
  describe "GET /diary_comments" do
    it "works! (now write some real specs)" do
      get diary_comments_path
      expect(response).to have_http_status(200)
    end
  end
end
