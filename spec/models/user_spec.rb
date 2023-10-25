# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User do
  it { is_expected.to validate_content_type_of(:avatar).allowing('image/jpeg') }
end
