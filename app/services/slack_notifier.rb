require 'rest-client'

module Services
  class SlackNotifier
    def self.send(opts)
      url = 'https://slack.com/api/chat.postMessage'
      options = {
        token: opts['token'],
        channel: opts['channel_id'],
        text: opts['text'],
        attachments: [opts['data']],
        as_user: true
      }
      Rails.logger.error("Starting send #{options.inspect}")
      begin
        RestClient.post()
      rescue Exception => e
        Rails.logger.error("Failed Post: #{e}")
      end

    end
  end
end
