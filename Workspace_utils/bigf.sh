#!/bin/bash
# Lista archivos grandes en el proyecto
find . -type f -exec du -h {} + | sort -rh | head -n 20
