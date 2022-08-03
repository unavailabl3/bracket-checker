require 'rails_helper'

RSpec.describe "Applications", type: :request do
  describe "GET /index" do
    it 'returns 200 OK status' do
      get '/'
      expect(response).to have_http_status(:ok)
    end
  end

  describe "POST /check" do
    let(:request_params){ { expressions: "[]" } }
    context "valid request parameter" do
      it 'returns 200 OK status' do
        post '/check', params: request_params
        expect(response).to have_http_status(200)
      end

      it 'renders check-result-block' do
        expected_block_html = '<div class="check-result">'
        
        post '/check', params: request_params
        expect(response.body).to include(expected_block_html)
      end
    end

    context "invalid request parameter" do
      it 'renders missing parameter message' do
        expected_message = "Expressions parameter is missing"

        post '/check'
        expect(response.body).to include(expected_message)
      end

      it 'does not renders check-result-block' do
        expected_block_html = '<div class="check-result">'
        
        post '/check'
        expect(response.body).to_not include(expected_block_html)
      end
    end
  end
end
