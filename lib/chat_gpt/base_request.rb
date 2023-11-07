module ChatGpt
  class BaseRequest
    require 'net/http'

    def post(params)
      uri = URI.parse(request_url)
      req = Net::HTTP::Post.new(uri)
      req.body = params[:data].to_json
      req.content_type = 'application/json'
      req['Authorization'] = "Bearer #{ENV['CHATGPT_API_KEY']}"
      response = Net::HTTP.start(uri.host, uri.port, use_ssl: uri.scheme == 'https') do |http|
        http.request(req)
      end
      JSON.parse(response&.body)
    end
  end
end
