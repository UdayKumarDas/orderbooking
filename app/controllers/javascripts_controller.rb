class JavascriptsController < ApplicationController
  skip_before_filter :verify_authenticity_token
  def dynamic_menus
    @menus=Menu.all
  end
end
