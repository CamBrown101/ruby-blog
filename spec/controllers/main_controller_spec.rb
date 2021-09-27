require 'rails_helper'

RSpec.describe MainController, type: :controller do
  describe "#index" do
    it "responds successfully" do
      get :index
      aggregate_failures do
        expect(response).to have_http_status "200"
        expect(response).to be_successful
      end
    end
  end
end