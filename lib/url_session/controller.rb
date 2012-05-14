module UrlSession::Controller
  def self.included(base)
    base.send :before_filter, :set_session_id
  end

  def url_options
    options     = Rails.application.config.session_options
    key         = options[:key]             || '_session_id'
    param       = options[:param]           || 'session_id'
    cookie      = !options[:cookie_enabled] || cookies[key].blank?
    session_id  = request.session_options[:id]
    { param.to_sym => cookie.presence && session_id }.merge super
  end

  def reset_session
    super
    set_session_id
  end

  private
  def set_session_id
    unless request.session_options[:id]
      request.session_options.merge!({:id => SecureRandom.hex(16)})
    end
  end
end
