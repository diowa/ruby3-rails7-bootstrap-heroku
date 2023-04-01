require 'rails_helper'

RSpec.describe ArticlePolicy do
  subject { described_class.new(user, article) }

  let(:article) { Article.new }

  context 'being a visitor' do
    let(:user) { nil }

    it { is_expected.to permit_action(:show) }
    it { is_expected.to forbid_action(:destroy) }
  end

  context 'being an administrator' do
    let(:user) { User.new(administrator: true) }

    it { is_expected.to permit_actions([:show, :destroy]) }
  end
end
