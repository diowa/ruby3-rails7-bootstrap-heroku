# frozen_string_literal: true

class School < ApplicationRecord
  include ChronoModel::TimeMachine

  belongs_to :city
  belongs_to :school_position

  delegate :position, to: :school_position, allow_nil: true

  has_one :country, through: :city

  has_many :students, dependent: :destroy

  validates :name, presence: true

  scope :sorted, -> { includes(:school_position).order('school_positions.position') }
end
