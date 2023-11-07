class ResponsesController < ApplicationController
  def generate
    response = ChatGpt::ResponseRequest.new(prompt: permitted_params[:prompt]).call

    respond_to do |format|
      format.html { render plain: response }
      format.json { render json: response }
    end
  end

  private

  def permitted_params
    params.permit(:prompt)
  end
end
