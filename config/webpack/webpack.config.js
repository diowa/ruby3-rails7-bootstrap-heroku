// See the shakacode/shakapacker README and docs directory for advice on customizing your webpackConfig.
const { generateWebpackConfig, merge } = require('shakapacker')

const webpackConfig = generateWebpackConfig()

const customConfig = {
  module: {
    rules: [{
      test: /\.scss$/,
      use: [{
        loader: 'sass-loader',
        options: {
          sassOptions: {
            silenceDeprecations: ['color-functions', 'global-builtin', 'import']
          }
        }
      }]
    }]
  }
}

module.exports = merge(webpackConfig, customConfig)
