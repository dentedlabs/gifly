class Team
  include NoBrainer::Document
  include NoBrainer::Document::Timestamps

  # field :id, uniq: true
  field :uid, type: String, index: true
  field :access_token, type: String, index: true
  field :scope, type: String
  field :state, type: String
  field :channel_id, type: String
end
