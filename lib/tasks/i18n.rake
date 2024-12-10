# frozen_string_literal: true

if %w[development test].include? Rails.env
  namespace :'i18n-tasks' do
    # rubocop:disable Rails/RakeEnvironment
    desc 'Run `bin/i18n-tasks health`'
    task :health do
      system(
        "#{RbConfig.ruby} \"#{Rails.root.join('bin/i18n-tasks')}\" health",
        exception: true
      )
    end
    # rubocop:enable Rails/RakeEnvironment
  end

  task(:lint).sources.push 'i18n-tasks:health'
end
