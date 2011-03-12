class ApplicationController < ActionController::Base
	protect_from_forgery

	before_filter :set_locale
               
	def set_locale
		# �i�H�N ["en", "zh-TW"] �]�w�� VALID_LANG ��� config/environment.rb ��
		if params[:locale] && ["en", "zh-TW"].include?( params[:locale] )
			session[:locale] = params[:locale]
		end

		I18n.locale = session[:locale] || I18n.default_locale
	end
end
