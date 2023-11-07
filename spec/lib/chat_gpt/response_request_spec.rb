require 'rails_helper'

RSpec.describe ChatGpt::ResponseRequest do
  describe '#call' do
    let(:response) { described_class.new(prompt: 'test').call }

    it 'returns the response on a successful call' do
      allow_any_instance_of(ChatGpt::BaseRequest).to receive(:post).and_return(JSON.parse(file_fixture('chatgpt_response_success.json').read))

      expect(response).to eq(JSON.parse(file_fixture('chatgpt_response_success.json').read)['choices'][0]['message']['content'])
    end

    it 'returns an error message on a failed call' do
      allow_any_instance_of(ChatGpt::BaseRequest).to receive(:post).and_return(JSON.parse(file_fixture('chatgpt_response_failure.json').read))

      expect(response).to eq('There was an error processing the request')
    end
  end
end
