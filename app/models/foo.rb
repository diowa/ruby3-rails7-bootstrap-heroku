# frozen_string_literal: true

class Foo < ApplicationRecord
  include ChronoModel::TimeGate

  validates :name, presence: true
end
