# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User do
  describe 'factory' do
    it 'works' do
      expect {
        build(:user)
      }.not_to raise_error
    end
  end
end
