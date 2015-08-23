class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :null_session

  protected

    def render_too_many_requests_response
      render_failure_response(I18n.t('messages.errors.too_many_requests'), 429)
    end

    def render_bad_request_response
      render_failure_response(I18n.t('messages.errors.invalid_request'), 422)
    end

    def render_unauthorized
      render_failure_response(I18n.t('messages.errors.users.invalid_user'), 401)
    end

    def render_success_response(data = {})
      render json: { data: data }, status: 200
    end

    def missing_params(exception)
      render_failure_response(I18n.t('messages.errors.invalid_request'), 422)
    end

    def render_failure_response(message, status)
      render json: { errors: { status: status, detail: message } }, status: status
    end
end
