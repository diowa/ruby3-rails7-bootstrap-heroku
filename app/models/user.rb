# frozen_string_literal: true

class User < ApplicationRecord
  has_one_attached :avatar

  # Remove `size: { greater_than: 0 }` to prevent failure or downgrade to 1.0.4
  validates :avatar, content_type: %w[image/jpeg], size: { greater_than: 0 }
end
