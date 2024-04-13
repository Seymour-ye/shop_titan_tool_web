class LanguagesController < ApplicationController
  def update
    session[:locale] = params[:id]

    redirect_back fallback_location: root_path
  end
end
