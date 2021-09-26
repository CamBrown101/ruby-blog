require 'rails_helper'

RSpec.describe "Main page", type: :request do
  it "responds successfully" do
    get root_path
    aggregate_failures do
      expect(response).to be_successful
      expect(response).to have_http_status "200"
    end
  end
end