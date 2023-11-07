require 'rails_helper'

RSpec.describe 'Responses', type: :request do
  describe 'GET /text' do
    before do
      allow_any_instance_of(ChatGpt::ResponseRequest).to receive(:call).and_return('This is a test.')
    end

    it 'returns a 200 OK' do
      get text_path
      expect(response.status).to eq(200), 'Code not 200'
    end

    let(:params) do
      { prompt: 'test' }
    end

    it 'calls the layer below it with the correct params' do
      expect(ChatGpt::ResponseRequest).to receive(:new).with(params).and_call_original

      get text_path(params)
    end
  end
end
