class ApplicationController < ActionController::Base

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

  def render_success_response(data = {}, opts = {})
    json_response = { attachments: [data] }.merge(opts)
    render json: json_response, status: 200
  end

  def missing_params(exception)
    render_failure_response(I18n.t('messages.errors.invalid_request'), 422)
  end

  def render_failure_response(message, status)
    render json: { meta: { status: status, message: message } }, status: status
  end

  private

  def get_paging collection
    paging = {}
    paging[:self] = "#{CONFIG.protocol}#{request.host_with_port}/#{request.params[:controller]}?page=#{collection.current_page}"
    if collection.next_page && collection.next_page > 0 && collection.next_page > collection.current_page
      paging[:next] = "#{CONFIG.protocol}#{request.host_with_port}/#{request.params[:controller]}?page=#{collection.next_page}"
    end
    if collection.prev_page && collection.prev_page > 0 && collection.prev_page < collection.current_page
      paging[:prev] = "#{CONFIG.protocol}#{request.host_with_port}/#{request.params[:controller]}?page=#{collection.prev_page}"
    end
    paging
  end

  def filter_to_query(hash)
    uri = ""
    if hash.present?
      url_params = []
      hash.map do |k,v|
        if(v.is_a?(Array))
          v.each do |k1, v2|
            url_params << "filter[#{k}][]=#{k1}"
          end
        else
          url_params << "filter[#{k}]=#{v}"
        end
      end
      uri = URI.encode(url_params.join('&')) + "&"
    end
    uri
  end

end
