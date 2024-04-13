class Link < ApplicationRecord
  has_many :views, dependent: :destroy
  
  scope :recent_first, -> { order(created_at: :desc) }
  # Ex:- scope :active, -> {where(:active => true)}

  validates :url, presence: true

  after_save_commit if: :url_previously_changed? do
    MetadataJob.perform_later(to_param)
  end

  # This overrides the usual id
  def to_param
    ShortCode.encode(id)
  end
  # Overrides the regular find used by Rails
  # If find is used with Link model, now uses this
  def self.find(id)
    super ShortCode.decode(id)
  end

  def domain
    URI(url).host rescue StandardError URI::InvalidURIError unless url.nil?
  end
end
