// ESLint 9 flat config.
//
// Replaces the legacy .eslintrc* model: this single file exports an
// ordered array of config objects. Later objects override earlier ones,
// and `files` glob patterns scope each block.
//
// We use the bundled `typescript-eslint` package (no @-prefix), which
// re-exports the parser and plugin together and provides the
// `tseslint.config()` helper that flattens recommended presets.

import js from '@eslint/js';
import tseslint from 'typescript-eslint';
import globals from 'globals';

export default tseslint.config(
  // Files we don't want to lint at all.
  {
    ignores: ['dist/**', 'node_modules/**', 'coverage/**'],
  },

  // ESLint's recommended JavaScript rules.
  js.configs.recommended,

  // typescript-eslint's recommended rule set, applied only to .ts files.
  ...tseslint.configs.recommended,

  // Project-specific tweaks for the backend source.
  {
    files: ['src/**/*.ts'],
    languageOptions: {
      ecmaVersion: 2022,
      sourceType: 'module',
      globals: {
        ...globals.node,
      },
    },
    rules: {
      // Allow `_`-prefixed unused parameters (common for unused `next`,
      // `req`, etc. in Express handlers and middleware).
      '@typescript-eslint/no-unused-vars': [
        'warn',
        { argsIgnorePattern: '^_', varsIgnorePattern: '^_' },
      ],
      // Be lenient about `any` for now; tighten later as types stabilise.
      '@typescript-eslint/no-explicit-any': 'warn',
    },
  },
);
