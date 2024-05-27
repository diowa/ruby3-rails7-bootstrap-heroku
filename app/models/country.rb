# frozen_string_literal: true

class Country < ApplicationRecord
  include ChronoModel::TimeMachine

  has_many :cities, dependent: :destroy
  has_many :schools, through: :cities
  has_many :students, through: :schools

  validates :name, presence: true

  has_one :council
  has_one :first_member, through: :council
end
