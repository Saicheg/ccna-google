class HomeController < ApplicationController
  def index
    @question = Question.search(params[:text]).first if params[:text]
    render layout: false
  end
end
