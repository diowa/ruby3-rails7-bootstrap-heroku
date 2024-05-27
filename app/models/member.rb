# frozen_string_literal: true

class Member < ApplicationRecord
  include ChronoModel::TimeMachine

  belongs_to :council
  has_one :country, through: :council

  scope :active, -> { where(active: true) }
end
