module ChatGpt
  class ResponseRequest < BaseRequest
    def initialize(params)
      @params = params
    end

    def call
      response = post(
        data: {
          "model": 'gpt-3.5-turbo',
          "messages": [{ "role": 'user', "content": "#{@params[:prompt]}" }],
          "temperature": 0.7
        }
      )
      if response['error'].nil?
        response['choices'][0]['message']['content']
      else
        'There was an error processing the request' # TODO: Add error handling
      end
    end

    private

    def request_url
      'https://api.openai.com/v1/chat/completions'
    end
  end
end
