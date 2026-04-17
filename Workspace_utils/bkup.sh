#!/bin/bash
# Hace backup comprimido del workspace actual
ZIP=backup_$(date +%Y%m%d_%H%M%S).zip
zip -r $ZIP . -x "*.venv*" "node_modules/*" "*.git*"
echo "✅ Backup creado: $ZIP"
