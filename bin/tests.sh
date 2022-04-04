#!/usr/bin/env bash
####################
## civi-zero      ##
##                ##
## Run unit tests ##
####################

# Strict mode
set -euo pipefail
IFS=$'\n\t'

# Include library
base_dir="$(builtin cd "$(dirname "${0}")" >/dev/null 2>&1 && pwd)"
. "${base_dir}/library.sh"

# Include configs
. "${base_dir}/../install.conf"
[[ -r "${base_dir}/../install.local" ]] && . "${base_dir}/../install.local"

# Parse options
install_dir="${1?:'Install dir missing'}"
extension="${2?:'Extension missing'}"
extension_target="${install_dir}/web/extensions"

print-header "Run unit tests (${extension})"
sudo chown -R "${USER}" "${install_dir}/web/"
cd "${extension_target}/${extension}"
XDEBUG_MODE=coverage "${install_dir}/vendor/bin/phpunit" --verbose --coverage-text
print-finish

exit 0