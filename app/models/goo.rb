# frozen_string_literal: true

class Goo < ApplicationRecord
  include ChronoModel::TimeMachine

  has_one :boo
end
