#!/bin/bash
# Instala dependencias npm/yarn y ejecuta build/test si hay package.json
test -f package.json && npm install && echo "✅ Dependencias npm instaladas."
test -f yarn.lock && yarn install && echo "✅ Dependencias yarn instaladas."
test -f package.json && npm run build 2>/dev/null
test -f package.json && npm test 2>/dev/null
