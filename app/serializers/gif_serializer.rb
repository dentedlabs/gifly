class GifSerializer < ActiveModel::Serializer
  attributes  :fallback,
              :image_url,
              :color

  def color
    "##{(0..2).map{"%0x" % (rand * 0x80 + 0x80)}.join}"
  end

  def fallback
    object.tags.join(' ')
  end

  def image_url
    object.source
  end
end
