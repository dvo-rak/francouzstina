#!/bin/bash
# Nasazení s automatickým verzováním.
# Použití: ./deploy.sh "popis změny"
# Verze = pořadové číslo commitu + datum, razítkuje se do index.html
# (const APP_VERSION), takže appka v menu vždycky ukazuje, jaké
# nasazení reálně běží — bez ručního bumpování.
set -euo pipefail

msg="${1:?Chybí commit message: ./deploy.sh \"popis zmeny\"}"

cd "$(dirname "$0")"

n=$(( $(git rev-list --count HEAD) + 1 ))
ver="$n ($(date +%Y-%m-%d))"

sed -i "s/^const APP_VERSION = .*/const APP_VERSION = \"$ver\";/" index.html
grep -q "APP_VERSION = \"$ver\"" index.html || { echo "Razítkování verze selhalo"; exit 1; }

git add -A
git commit -m "$msg"
git push
echo "Nasazeno jako v$ver"
