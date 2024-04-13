class LanguagesController < ApplicationController
  def update
    session[:locale] = params[:language]

    redirect_back fallback_location: root_path
  end
end
