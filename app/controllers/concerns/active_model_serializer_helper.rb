module ActiveModelSerializerHelper
  extend ActiveSupport::Concern

  included do
    def common_serializer(serializer, options: {}, adapter: :flatten_json)
      adapter_class = ActiveModel::Serializer::Adapter.adapter_class(adapter)
      adapter_class.new(serializer, options)
    end
  end

  class_methods do
    def array_serializer(collection, options: {}, adapter: :flatten_json)
      serializer = ActiveModel::Serializer::ArraySerializer.new(collection)
      common_serializer(serializer, options, adapter)
    end

    def serializer(object, options: {}, adapter: :flatten_json)
      serializer = ActiveModel::Serializer.serializer_for(object).new(object)
      common_serializer(serializer, options, adapter)
    end
  end

end
