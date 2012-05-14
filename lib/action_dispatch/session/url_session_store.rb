require 'active_support/cache'
require 'action_dispatch/middleware/session/abstract_store'
require 'action_dispatch/middleware/session/dalli_store'
require 'dalli'

module ActionDispatch
  module Session
    class UrlSessionStore < DalliStore

      def initialize(app, options = {})
        super

        @default_options  = { :param => 'session_id',
          :cookie_enabled => false }.merge(@default_options)
        @cookie_enabled   = @default_options[:cookie_enabled]
        @param            = @default_options[:param].to_s
      end

      private

      def set_cookie(*args)
        super if @cookie_enabled
      end

      def extract_session_id(env)
        request = ActionDispatch::Request.new(env)
        (
          (super if @cookie_enabled) ||
          request.path.scan(/^\/(\w{32})/).flatten.first ||
          request.query_parameters[@param].to_s.scan(/^(\w{32})$/).flatten.first
        ).presence
      end
    end
  end
end
