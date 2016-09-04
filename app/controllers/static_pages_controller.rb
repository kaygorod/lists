class StaticPagesController < ApplicationController
  def home
    @lists = List.all
  end
end
