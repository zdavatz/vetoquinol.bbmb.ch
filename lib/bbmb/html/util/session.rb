#!/usr/bin/env ruby
# Html::Util::Session -- bbmb.ch -- 15.09.2006 -- hwyss@ywesee.com

require 'bbmb/config'
require 'bbmb/html/util/lookandfeel'
require 'bbmb/html/state/login'
require 'sbsm/session'

module BBMB
  module Html
    module Util
class Session < SBSM::Session
  #DEFAULT_FLAVOR = 'vetoquinol'
  DEFAULT_LANGUAGE = 'de'
  DEFAULT_STATE = State::Login
  EXPIRES = BBMB.config.session_timeout
  LOOKANDFEEL = Lookandfeel
  PERSISTENT_COOKIE_NAME = "bbmb-barcodereader"
  def http_headers
    if(redirect?) 
      event, args = @state.direct_event
      { 
        "Location" => lookandfeel._event_url(event, args || {}),
      }
    else
      super 
    end
  end
  def login
    @user = @app.login(user_input(:email), user_input(:pass))
  end
  def logout
    @app.logout(@user.auth_session) if(@user.respond_to?(:auth_session))
    super
  end
  def redirect?
    @state.direct_event && @request_method != 'GET'
  end
  def to_html
    if(redirect?)
      ''
    else
      super
    end
  end
  if(BBMB.config.debug)
    def process(*args)
      super
      BBMB.logger.debug('event') { event }
    end
  end
end
    end
  end
end