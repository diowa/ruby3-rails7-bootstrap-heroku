// See the shakacode/shakapacker README and docs directory for advice on customizing your webpackConfig.
const { generateWebpackConfig } = require('shakapacker')

const webpackConfig = generateWebpackConfig()

// Find sass-loader and inject silenceDeprecations
webpackConfig.module.rules.forEach(rule => {
  if (rule.test?.toString().includes('scss') && Array.isArray(rule.use)) {
    rule.use.forEach(loader => {
      if (loader?.loader?.includes('sass-loader')) {
        loader.options.sassOptions.silenceDeprecations = [
          'color-functions',
          'global-builtin',
          'if-function',
          'import'
        ]
      }
    })
  }
})

module.exports = webpackConfig
