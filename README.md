# Gifly

Messaging on Slack can be boring if only just webhooks from GitHub/Bitbucket and your CI Servers. Let's spice it up with a little gif fun.

## Dependencies
- Ruby 2.1.5 (.ruby-version included)
- RethinkDB (default config for development)

## Test with RSpec
      rake nobrainer:sync_schema # if any issues, but should run under development when server is run
      bundle exec rspec

## TODO
- Slack Integration
  - Previewer
  - Remove by any user
- autogen when CI server breaks, with a tag of last checkin
- Web UI
- User Submissions
