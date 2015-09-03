class Team
  include NoBrainer::Document
  include NoBrainer::Document::Timestamps

  # field :id, type: String, uniq: true
  field :code, type: String
  field :name, type: String
  field :access_token, type: String, uniq: true, index: true
  field :scope, type: String
  field :channel_id, type: String
  field :configuration_url, type: String
  field :webhook_url, type: String
end
