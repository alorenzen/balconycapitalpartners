require 'openid/store/filesystem'
Rails.application.config.middleware.use OmniAuth::Builder do
  use OmniAuth::Strategies::GoogleApps, OpenID::Store::Filesystem.new('./tmp'), :name => 'partners', :identifier => 'https://www.google.com/accounts/o8/id', :domain => 'balconycapitalpartners.com'
end
