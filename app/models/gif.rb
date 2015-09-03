class Gif
  include NoBrainer::Document
  include NoBrainer::Document::Timestamps

  field :id, :uniq => { scope: :source }
  field :source, type: String
  field :tags, type: Array, index: :multi, default: []
  field :rating, type: String
  belongs_to :user
end
