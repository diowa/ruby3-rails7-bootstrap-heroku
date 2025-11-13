// See the shakacode/shakapacker README and docs directory for advice on customizing your webpackConfig.
const { generateWebpackConfig } = require('shakapacker')

// Get the base webpack config from shakapacker
const webpackConfig = generateWebpackConfig()

// Find and modify the sass-loader rule to silence deprecation warnings
if (webpackConfig.module && webpackConfig.module.rules) {
  webpackConfig.module.rules.forEach(rule => {
    // Find the rule that handles SCSS/SASS files
    if (rule.test && rule.test.toString().includes('scss') && Array.isArray(rule.use)) {
      rule.use.forEach(loader => {
        // Find the sass-loader in the use array
        if (loader && loader.loader && loader.loader.includes('sass-loader')) {
          // Add silenceDeprecations to the sassOptions
          loader.options = loader.options || {}
          loader.options.sassOptions = loader.options.sassOptions || {}
          loader.options.sassOptions.silenceDeprecations = [
            'color-functions',
            'global-builtin',
            'import'
          ]
        }
      })
    }
  })
}

module.exports = webpackConfig
