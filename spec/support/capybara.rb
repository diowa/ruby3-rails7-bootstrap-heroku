# frozen_string_literal: true

Capybara.register_driver :custom_chrome do |app|
  # Opt-out for Selenium data collection.
  #
  # Note: This is the only available method to disable telemetry at this point.
  # Configuring the driver here is too late as the manager is already set at
  # the system level.
  #
  # To test that telemetry is not being send, use the command:
  # `DEBUG=true SE_CLEAR_CACHE=true rspec`
  #
  # Ref: SeleniumHQ/selenium#13173
  ENV['SE_AVOID_STATS'] = 'true'

  opts = Selenium::WebDriver::Chrome::Options.new

  # See https://github.com/GoogleChrome/chrome-launcher/blob/main/docs/chrome-flags-for-tools.md
  # See https://github.com/puppeteer/puppeteer/blob/main/packages/puppeteer-core/src/node/ChromeLauncher.ts#L169C10-L169C32
  disabled_features = [
    'Translate',
    'AcceptCHFrame', # crbug.com/1348106
    'MediaRouter',
    'OptimizationHints',
    'ProcessPerSiteUpToMainFrameThreshold', # crbug.com/1492053
    'IsolateSandboxedIframes', # https://github.com/puppeteer/puppeteer/issues/10715
  ]

  enabled_features = [
    'PdfOopif',
  ]

  opts.add_argument('allow-pre-commit-input')
  opts.add_argument('disable-background-networking')
  opts.add_argument('disable-background-timer-throttling')
  opts.add_argument('disable-backgrounding-occluded-windows')
  opts.add_argument('disable-breakpad')
  opts.add_argument('disable-client-side-phishing-detection')
  opts.add_argument('disable-component-extensions-with-background-pages')
  opts.add_argument('disable-crash-reporter') # No crash reporting in CfT
  opts.add_argument('disable-default-apps')
  opts.add_argument('disable-dev-shm-usage')
  opts.add_argument('disable-extensions')
  opts.add_argument('disable-hang-monitor')
  opts.add_argument('disable-infobars')
  opts.add_argument('disable-ipc-flooding-protection')
  opts.add_argument('disable-popup-blocking')
  opts.add_argument('disable-prompt-on-repost')
  opts.add_argument('disable-renderer-backgrounding')
  opts.add_argument('disable-search-engine-choice-screen')
  opts.add_argument('disable-sync')
  opts.add_argument('enable-automation')
  opts.add_argument('export-tagged-pdf')
  opts.add_argument('force-color-profile=srgb')
  opts.add_argument('generate-pdf-document-outline')
  opts.add_argument('metrics-recording-only')
  opts.add_argument('no-first-run')
  opts.add_argument('password-store=basic')
  opts.add_argument('use-mock-keychain')

  opts.add_argument("disable-features=#{disabled_features.join(',')}")
  opts.add_argument("enable-features=#{enabled_features.join(',')}")

  opts.add_argument('window-size=1024,768')

  unless ActiveModel::Type::Boolean::FALSE_VALUES.include?(ENV['HEADLESS'])
    opts.add_argument('headless=new')
    opts.add_argument('hide-scrollbars')
    opts.add_argument('mute-audio')
  end

  Capybara::Selenium::Driver.new(app, browser: :chrome, options: opts)
end

Capybara.configure do |config|
  config.default_max_wait_time = 10
  config.default_driver = :custom_chrome
  config.javascript_driver = :custom_chrome
  config.disable_animation = true
end
