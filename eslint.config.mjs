import neostandard from 'neostandard'

export default [
  {
    ignores: [
      'app/assets/config/manifest.js',
      'app/assets/javascript/**/vendor/*.js',
      'config/**/*.js',
    ]
  },
  ...neostandard(),
  {
    settings: {
      'import/resolver': {
        node: {
          paths: ['app/javascript'],
        }
      }
    }
  }
]
