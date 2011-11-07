require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class PicPlz < OmniAuth::Strategies::OAuth2
      option :client_options, {
        :site => 'https://picplz.com',
        :authorize_url => '/oauth2/authenticate',
        :token_url => '/oauth2/access_token'
      }

      def request_phase
        options[:authorize_params] = client_params.merge(options[:authorize_params])
        super
      end
      
      def auth_hash
        OmniAuth::Utils.deep_merge(super, client_params.merge({
          :grant_type => 'authorization_code'}))
      end

      private
      
      def client_params
        {:client_id => options[:client_id], :redirect_uri => callback_url ,:response_type => "code"}
      end
    end
  end
end
OmniAuth.config.add_camelization 'picplz', 'PicPlz'