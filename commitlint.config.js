module.exports = {
    extends: ['@commitlint/config-conventional'],
    parserPreset: {
      parserOpts: {
        // Match: type(scope)?: JIRA-TICKET subject
        headerPattern: /^(\w+)(?:\(([^)]+)\))?!?: (GENOPSX|GAUT)-\d+ (.+)$/,
        headerCorrespondence: ['type', 'scope', 'jira', 'subject'],
      },
    },
    formatter: '@commitlint/format',
    rules: {
      'type-enum': [
        2,
        'always',
        [
          'build',
          'chore',
          'ci',
          'docs',
          'feat',
          'fix',
          'perf',
          'refactor',
          'revert',
          'style',
          'test',
        ],
      ],
      'type-case': [2, 'always', 'lower-case'],
      'type-empty': [2, 'never'],
      'scope-case': [2, 'always', 'lower-case'],
      'subject-empty': [2, 'never'],
  
      // ✅ Disable subject-case to allow ticket prefix
      'subject-case': [0],
  
      'body-leading-blank': [1, 'always'],
      'footer-leading-blank': [1, 'always'],
    },
  };
  