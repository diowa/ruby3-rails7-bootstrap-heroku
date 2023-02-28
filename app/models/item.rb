# frozen_string_literal: true

class Item
  include ActiveModel::Model

  attr_accessor :expire_date

  validates_date :expire_date
end
