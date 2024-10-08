module.exports = {
  root: true,
  ignorePatterns: [
    '/app/assets/config/manifest.js',
    '/app/assets/javascript/**/vendor/*.js',
    '/config/**/*.js'
  ],
  extends: [
    'standard'
  ],
  settings: {
    'import/resolver': {
      node: {
        paths: ['app/javascript']
      }
    }
  }
}
