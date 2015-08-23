class Gif
  include NoBrainer::Document
  include NoBrainer::Document::Timestamps

  field :source, type: String
  field :tags, type: Array, index: true
  belongs_to :user
end
