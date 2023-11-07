require 'rails_helper'

RSpec.describe ChatGpt::BaseRequest do
  let(:http_response) { double('HTTP RESPONSE') }
  before do
    allow(Net::HTTP).to receive(:start) { http_response }
    allow(http_response).to receive(:body) { response_body }
  end

  describe '#post' do
    let(:params) do
      {
        data: {
          "prompt": 'test'
        }
      }
    end
    let(:inheriting_request) { ChatGpt::ResponseRequest.new(prompt: 'test') }
    let(:response_body) do
      {
        'post_request_data': 'test',
        'value': 1
      }.to_json
    end

    before do
      allow(Net::HTTP).to receive(:start) { http_response }
      allow(http_response).to receive(:body) { response_body }
    end

    it 'returns the response body' do
      expect(inheriting_request.post(params)).to eq(JSON.parse(response_body))
    end
  end
end
