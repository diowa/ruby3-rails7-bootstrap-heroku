# frozen_string_literal: true

class Boo < ApplicationRecord
  include ChronoModel::TimeMachine

  belongs_to :goo
end
