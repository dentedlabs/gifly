class User
  include NoBrainer::Document
  include NoBrainer::Document::Timestamps

  field :name, type: String, index: true
end
