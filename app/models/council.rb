# frozen_string_literal: true

class Council < ApplicationRecord
  include ChronoModel::TimeMachine

  belongs_to :country

  has_many :members, dependent: :destroy

  # Problem is caused by `where` in the `scope`
  has_one :first_member, -> { as_of(1.second.ago).active }, class_name: 'Member', dependent: nil, inverse_of: false
end
