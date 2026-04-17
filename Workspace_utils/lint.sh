#!/bin/bash
# Ejecuta linters sobre todo el workspace
if command -v flake8 >/dev/null 2>&1; then
  flake8 .
fi
if command -v eslint >/dev/null 2>&1 && [ -d node_modules ]; then
  npx eslint .
fi
if command -v shellcheck >/dev/null 2>&1; then
  find . -type f -name "*.sh" -exec shellcheck {} +
fi
