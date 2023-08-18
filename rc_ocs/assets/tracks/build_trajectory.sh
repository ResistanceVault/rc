#!/bin/bash

# Verifica che siano stati forniti due argomenti
if [ $# -ne 2 ]; then
  echo "Usage: $0 <xml_file> <object_name>"
  exit 1
fi

xml_file="$1"
object_name="$2"

# Verifica che il file XML esista
if [ ! -f "$xml_file" ]; then
  echo "File not found: $xml_file"
  exit 1
fi

# Estrai le proprietà x e y del nodo <object>
x=$(grep -A 1 "name=\"$object_name\"" "$xml_file" | grep -oP '(?<=x=")[^"]+' | tr ',' '.')
y=$(grep -A 1 "name=\"$object_name\"" "$xml_file" | grep -oP '(?<=y=")[^"]+' | tr ',' '.')

# Estrai i punti dal nodo <polygon>
points=$(grep -A 1 "name=\"$object_name\"" "$xml_file" | grep -oP '(?<=<polygon points=")[^"]+')

# Calcola e stampa le coordinate assolute dei punti con approssimazione
IFS=' ' read -ra point_array <<< "$points"
for point in "${point_array[@]}"; do
  IFS=',' read -ra coordinates <<< "$point"
  result_x=$(echo "${coordinates[0]} $x " | awk '{print $1 + $2}')
  result_y=$(echo "${coordinates[1]} $y " | awk '{print $1 + $2}')
  mod=${result_x//[ ]/,}
  mod2=${result_y//[ ]/,}
  hexx=$(printf "%.0f" "$mod")
  hexy=$(printf "%.0f" "$mod2")
  printf "%04x %04x " $hexx $hexy
done
