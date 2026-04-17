#!/bin/bash
# Lanza docker-compose up si existe docker-compose.yml
test -f docker-compose.yml && docker-compose up || echo "❌ No hay docker-compose.yml"
