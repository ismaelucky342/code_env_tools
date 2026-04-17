#!/bin/bash
# Mata el proceso que usa un puerto específico
if [ -z "$1" ]; then
  echo "Uso: kport <puerto>"; exit 1
fi
PID=$(sudo lsof -t -i:$1)
if [ -n "$PID" ]; then
  kill -9 $PID && echo "🔪 Proceso $PID en puerto $1 matado."
else
  echo "❌ Ningún proceso en puerto $1."
fi
