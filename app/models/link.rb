class Link < ApplicationRecord
  scope :recent_first, -> { order(created_at: :desc) }
  # Ex:- scope :active, -> {where(:active => true)}

  validates :url, presence: true

  # This overrides the usual id
  def to_param
    ShortCode.encode(id)
  end
  # Overrides the regular find used by Rails
  # If find is used with Link model, now uses this
  def self.find(id)
    super ShortCode.decode(id)
  end
end
