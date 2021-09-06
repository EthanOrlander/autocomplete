#!/bin/sh

# If ALLOW_LOCKFILE_CHANGE is set, exit 0
if [ ! -z "${ALLOW_LOCKFILE_CHANGE}" ]; then
    echo "✨ lockfile changes allowed"
    exit
fi

echo "Checking for lockfile changes..."

# diff="$(git diff origin/master -- package-lock.json)"
# Make temp folder if not exists
if [ ! -d "scripts/temp" ]; then
    mkdir scripts/temp
fi

# Download upstream to temp/package-lock.json
wget -O scripts/temp/package-lock.json https://raw.githubusercontent.com/withfig/autocomplete/master/package-lock.json &> /dev/null

# Run diff
diff="$(diff scripts/temp/package-lock.json package-lock.json --brief)"

# Clead up temp folder
rm -rf scripts/temp &> /dev/null

# If no difference
if [ -z ${#diff} ]; then
    echo "✨ lockfile unchanged"
# If difference
else
    echo "🛑 package-lock.json does not match upstream https://raw.githubusercontent.com/withfig/autocomplete/master/package-lock.json"
    echo "If this is intentional, please run with ALLOW_LOCKFILE_CHANGE=1?"
    echo "If this is unintentional, rebase upstream or run \"npm run sync-packages-upstream\""
    exit 1
fi
exit 0