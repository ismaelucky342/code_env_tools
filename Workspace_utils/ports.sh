#!/bin/bash
# Muestra puertos abiertos y procesos asociados
sudo lsof -i -P -n | grep LISTEN
