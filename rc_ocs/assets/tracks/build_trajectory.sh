#!/bin/bash

function get_value() {
  read line1
  if [[ $line1 =~ name=\"([^\"]+)\" && "${BASH_REMATCH[1]}" == "action" ]]; then
    # Se l'attributo name è "action", estrai il valore
    if [[ $line1 =~ value=\"([^\"]+)\" ]]; then
      actionstr="${BASH_REMATCH[1]}"
      if [ "$actionstr" = "sail" ]; then
        action=32768
        #echo "Il valore per action è: $action"
      fi
      if [ "$actionstr" = "brake" ]; then
        action=16384
        #echo "Il valore per action è: $action"
      fi
    fi
  fi
  
  if [[ $line1 =~ name=\"([^\"]+)\" && "${BASH_REMATCH[1]}" == "treshold" ]]; then
    # Se l'attributo name è "treshold", estrai il valore
    if [[ $line1 =~ value=\"([^\"]+)\" ]]; then
      treshold="${BASH_REMATCH[1]}"
      #echo "Il valore per treshold è: $value"
    fi
  fi
}
function check_square_zone() {
  action=0
  treshold=0
  while IFS= read -r line; do
    if [[ $line == *"<object"* && $line == *"type=\"modifier\""* ]]; then
        x1_value=$(echo "$line" | grep -o 'x="[^"]*' | awk -F'"' '{print $2}')
        x1_value=$(echo "$x1_value" | tr '.' "$decimal_point")
        x1_value=$(printf "%.0f" "$x1_value")
        y1_value=$(echo "$line" | grep -o 'y="[^"]*' | awk -F'"' '{print $2}')
        y1_value=$(echo "$y1_value" | tr '.' "$decimal_point")
        y1_value=$(printf "%.0f" "$y1_value")
        width_value=$(echo "$line" | grep -o 'width="[^"]*' | awk -F'"' '{print $2}')
        width_value=$(echo "$width_value" | tr '.' "$decimal_point")
        width_value=$(printf "%.0f" "$width_value")
        height_value=$(echo "$line" | grep -o 'height="[^"]*' | awk -F'"' '{print $2}')
        height_value=$(echo "$height_value" | tr '.' "$decimal_point")
        height_value=$(printf "%.0f" "$height_value")
        #echo "aaaaaaaa $x1_value"
        #echo "bbbbbbb $y_value"
        #echo "bbbbbbb $width_value"
        #echo "bbbbbbb $height_value"

        x2_value=$(($x1_value + $width_value))
        y2_value=$(($y1_value + $height_value))

        #echo "check if $hexx between $x1_value and $x2_value"
        #echo "check if $hexy between $y1_value and $y2_value"

        if ((hexx >= x1_value && hexx <= x2_value && hexy >= y1_value && hexy <= y2_value)); then
          read line1
          get_value
          get_value
        fi
    fi
done < "$xml_file"
}

# Verifica che siano stati forniti due argomenti
if [ $# -ne 1 ]; then
  echo "Usage: $0 <xml_file>"
  exit 1
fi

xml_file="$1"
object_name="trajectory"

# Verifica che il file XML esista
if [ ! -f "$xml_file" ]; then
  echo "File not found: $xml_file"
  exit 1
fi

# get decima separator
decimal_point=$(locale -k LC_NUMERIC | awk -F'=' '/decimal_point/{print $2}' | tr -d '"')

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
  mod=$(echo "$mod" | tr '.' "$decimal_point")
  mod2=${result_y//[ ]/,}
  mod2=$(echo "$mod2" | tr '.' "$decimal_point")
  hexx=$(printf "%.0f" "$mod")
  hexy=$(printf "%.0f" "$mod2")

  check_square_zone
  #echo "action $action"
  #echo "treshold $treshold"
  hexy=$(($hexy + $action + $treshold * 256))

  printf "%04x %04x " $hexx $hexy
done
