#!/bin/bash

set -eo pipefail

dir="$(dirname $0)"
model="$dir/thorsten-hessisch.onnx"

# Debugging: Ausgabe des Verzeichnisses und Modells
echo "Verzeichnis: $dir"
echo "Modell: $model"

# Verwende die primäre Auswahl, um den aktuell markierten Text zu erhalten
data=$(xclip -out -selection primary)
# Debugging: Ausgabe der Länge der Daten
echo "Länge der Daten: ${#data}"

if [ ${#data} -gt 2 ]; then
    # Debugging: Ausgabe der Daten
    echo "Daten: $data"
    echo "$(date) data: $data" >> /tmp/piper.log &
    echo "$data" | "$dir"/piper --model "$model" --output_raw | play -t raw -r 22050 -e signed-integer -b 16 -
else
    echo "Keine ausreichenden Daten zum Vorlesen."
fi
