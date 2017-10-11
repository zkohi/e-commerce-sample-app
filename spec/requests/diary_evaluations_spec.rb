require 'rails_helper'

RSpec.describe "DiaryEvaluations", type: :request do
  describe "GET /diary_evaluations" do
    it "works! (now write some real specs)" do
      get diary_evaluations_path
      expect(response).to have_http_status(200)
    end
  end
end
