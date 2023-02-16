class ApplicationController < ActionController::Base
	include Pagy::Backend
	before_action :set_locale

	def default_url_options
		{ locale: I18n.locale }
	end
	def set_admin_locale
	  I18n.locale = :en
	end
	def set_current_user
	    User.current_user = current_user
	end
	private
		def set_locale
			locale = params[:locale].to_s.strip.to_sym
			I18n.locale = I18n.available_locales.include?(locale) ? locale : I18n.default_locale
		end
end
