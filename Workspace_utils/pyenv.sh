#!/bin/bash
# Crea y activa entorno virtual Python, instala requirements.txt si existe
if [ ! -d ".venv" ]; then
  python3 -m venv .venv && echo "✅ Entorno virtual creado."
else
  echo "⚡ Entorno virtual ya existe."
fi
source .venv/bin/activate
if [ -f requirements.txt ]; then
  pip install -r requirements.txt
fi
