class Gif
  include NoBrainer::Document
  include NoBrainer::Document::Timestamps

  field :source, type: String
  field :tags, type: Array, index: true, default: []
  field :rating, type: String
  belongs_to :user
end
