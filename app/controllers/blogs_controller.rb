class BlogsController < ApplicationController
  before_action :authenticate, only: [:new, :create]


  def new
    @blog = Blog.new
  end


  private
  
  def authenticate
    redirect_to root_path unless user_signed_in?
  end

end
