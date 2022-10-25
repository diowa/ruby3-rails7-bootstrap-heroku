# frozen_string_literal: true

class Box < ApplicationRecord
  include ChronoModel::TimeMachine

  validates :name, presence: true
end
