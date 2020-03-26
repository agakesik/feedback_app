class StaticPagesController < ApplicationController
  def home
    render html: "hello world"
  end

  def help
  end
end
