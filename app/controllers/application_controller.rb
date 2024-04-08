class ApplicationController < ActionController::Base
    around_action :switch_locale

    private

    def switch_locale(&action)
      logger.debug "* Accept-Language: #{request.env['HTTP_ACCEPT_LANGUAGE']}"
      locale = params[:locale] || extract_locale_from_accept_language_header
      logger.debug "* Locale set to '#{locale}'"
      I18n.with_locale(locale, &action)
    end

    def extract_locale_from_accept_language_header
      request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first
    end

    def default_url_options
        { locale: I18n.locale }
    end
end
