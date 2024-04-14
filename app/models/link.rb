class Link < ApplicationRecord
  belongs_to :user, optional: true

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
    # super ShortCode.decode(id)
    super (id.is_a?(Integer) ? id : ShortCode.decode(id))
  end

  def domain
    URI(url).host rescue StandardError URI::InvalidURIError unless url.nil?
  end

  # Links are not editable if there is no user ID
  # Returns false if no user_id on Link
  # Returns true or false if user.id matches user_id on Link
  def editable_by?(user)
    user_id? && (user_id == user&.id)
  end
end
