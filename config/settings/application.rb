SimpleConfig.for :application do

  set :protocol, 'http://'

  group :slack do
    set :api, '4w977zGnbMg6iKiYXX3lNAnq'
    set :key, '4611793306.10070057840'
    set :secret, '0e0c6e028ee6a8e357d216d6d6c73032'
    set :access_token_url, 'https://slack.com/api/oauth.access'
  end

  # put any trusted ips here, both internet and intranet addresses
  group :rate_limiting do
    set :whitelist, ['127.0.0.1']
  end

end
