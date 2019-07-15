# frozen_string_literal: true

class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters, if: :devise_controller?
    #helper_method :resource, :resource_name, :devise_mapping
    #before_action :resource_name, :resource, :devise_mapping

    protected
    def configure_permitted_parameters
        devise_parameter_sanitizer.permit :sign_up
        devise_parameter_sanitizer.permit :account_update
    end
end
