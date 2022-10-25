# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Chronomodel' do
  subject { Student.as_of(Time.zone.now).includes(:school, :city, :country).map(&:country).all? }

  before do
    france = Country.create!(name: 'France')
    italy = Country.create!(name: 'Italy')

    paris = france.cities.create!(name: 'Paris')
    rome = italy.cities.create!(name: 'Rome')

    pascal = paris.schools.create!(name: 'B. Pascal')
    galilei = rome.schools.create!(name: 'G. Galilei')

    pascal.students.create!(name: 'Vincent')
    galilei.students.create!(name: 'Mario')
  end

  it { is_expected.to be true }
end
