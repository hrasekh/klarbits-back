# app/middleware/set_locale.rb
require 'rack'

class SetLocale
  def initialize(app)
    @app = app
  end

  def call(env)
    request = Rack::Request.new(env)
    locale = request.params['locale'] || I18n.default_locale.to_s
    I18n.locale = Current.locale = locale
    @app.call(env)
  ensure
    # Reset the current locale after the request is finished
    I18n.locale = I18n.default_locale
    Current.locale = nil
  end
end
