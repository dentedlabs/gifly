SimpleConfig.for :application do

  set :protocol, 'http://'
  set :slack_token, '4w977zGnbMg6iKiYXX3lNAnq'

  # put any trusted ips here, both internet and intranet addresses
  group :rate_limiting do
    set :whitelist, ['127.0.0.1']
  end

end
