# frozen_string_literal: true

class SchoolPosition < ApplicationRecord
  include ChronoModel::TimeGate

  validates :position, presence: true, numericality: { only_integer: true }
end
