#!/usr/bin/env bash
set -e

replace_env() {
	pat="s/NATS_SERVER [0-9]+\.[0-9]+\.[0-9]+/NATS_SERVER ${1}/g"
	if [[ $OSTYPE == "darwin"* ]]; then
		sed -i'.sedibak' -E "$pat" $2
		find . -name "*.sedibak" -delete
	fi
	if [[ $OSTYPE == "linux"* ]]; then
		sed --in-place --regexp-extended "$pat" $2
	fi
}

replace_tag() {
	pat="s/nats:[0-9]+\.[0-9]+\.[0-9]+/nats:${1}/g"
	if [[ $OSTYPE == "darwin"* ]]; then
		sed -i'.sedibak' -E "$pat" $2
		find . -name "*.sedibak" -delete
	fi
	if [[ $OSTYPE == "linux"* ]]; then
		sed --in-place --regexp-extended "$pat" $2
	fi
}

if [[ "$(pwd)" != *"nats-server" ]]; then
	echo "$(basename "${0}") this command must be run from the repository top level directory"
	exit 1
fi

current_version="2.2.2"
new_version="${1}"
if [[ ${new_version} == "" ]]; then
	echo "usage: ${0} <server version>"
	echo "       ${0} 2.2.0"
	exit 1
fi

echo "current version: ${current_version}"
echo "new version: ${new_version}"

echo "updating files..."
files=$(grep --recursive --binary-files=without-match --files-with-matches --extended-regexp "NATS_SERVER [0-9]+\.[0-9]+\.[0-9]+" ./*)
replace_env "$new_version" "$files"

files=$(grep --recursive --binary-files=without-match --files-with-matches --extended-regexp "nats:[0-9]+\.[0-9]+\.[0-9]+" ./*)
replace_tag "$new_version" "$files"

echo "renaming directory..."
git mv "${current_version}" "${new_version}"
