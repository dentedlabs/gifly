module ActiveModelSerializerHelper
  extend ActiveSupport::Concern

  included do
  end

  def self.array_serializer(collection, options: {}, adapter: :flatten_json)
    serializer = ActiveModel::Serializer::ArraySerializer.new(collection)
    adapter_class = ActiveModel::Serializer::Adapter.adapter_class(adapter)
    adapter_class.new(serializer, options)
  end

  def self.serializer(object, options: {}, adapter: :flatten_json)
    serializer = ActiveModel::Serializer.serializer_for(object).new(object)
    adapter_class = ActiveModel::Serializer::Adapter.adapter_class(adapter)
    adapter_class.new(serializer, options)
  end

end
