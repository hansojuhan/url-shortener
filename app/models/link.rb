class Link < ApplicationRecord
  scope :recent_first, -> { order(created_at: :desc) }
  # Ex:- scope :active, -> {where(:active => true)}

  validates :url, presence: true
end
