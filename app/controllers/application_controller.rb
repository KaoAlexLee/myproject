class ApplicationController < ActionController::Base
	protect_from_forgery

	before_filter :set_locale
               
	def set_locale
		# 可以將 ["en", "zh-TW"] 設定為 VALID_LANG 放到 config/environment.rb 中
		if params[:locale] && ["en", "zh-TW"].include?( params[:locale] )
			session[:locale] = params[:locale]
		end

		I18n.locale = session[:locale] || I18n.default_locale
	end
end
