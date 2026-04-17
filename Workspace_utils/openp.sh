#!/bin/bash
# Abre el proyecto en VS Code
if command -v code >/dev/null 2>&1; then
  code .
else
  echo "❌ VS Code no está instalado."
fi
