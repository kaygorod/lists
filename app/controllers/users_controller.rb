class UsersController < ApplicationController
  before_filter :authenticate_user! # для Devise
  #load_and_authorize_resource # for cancancan
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @lists = @user.lists
  end
end
