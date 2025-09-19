module.exports = {
  printWidth: 120,
  useTabs: false,
  tabWidth: 2,
  singleQuote: true,
  trailingComma: 'all',
  semi: true,
  endOfLine: 'lf',
  htmlWhitespaceSensitivity: 'ignore',

  overrides: [
    {
      files: ['**/*.css'],
      options: {
        singleQuote: false,
      },
    },
    {
      files: ['**/*.md'],
      options: {
        tabWidth: 4,
        singleQuote: false,
      },
    },
    {
      files: ['**/*.{jsx,tsx}'],
      options: {
        singleQuote: true,
        jsxSingleQuote: true,
      },
    },
  ],
};
