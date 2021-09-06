#!/bin/sh

echo "[1/3] 🗑️  uninstalling node_modules. This may take a minute.."
rm -rf node_modules
echo "[2/3] 🔄 resetting package-lock.json..."
rm package-lock.json
wget -O package-lock.json https://raw.githubusercontent.com/withfig/autocomplete/master/package-lock.json &> /dev/null
echo "[3/3] ⬇️  re-installing node_modules. This may take a minute..."
npm install &> /dev/null
echo "✨ package-lock.json has been reset"