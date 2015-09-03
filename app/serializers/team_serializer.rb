class TeamSerializer < ActiveModel::Serializer
  attributes  :access_token,
              :scope,
              :channel_id

end
