#!/usr/bin/env sh
# shellcheck shell=sh
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
##@Version           :  202304081841-git
# @@Author           :  Jason Hempstead
# @@Contact          :  jason@casjaysdev.com
# @@License          :  WTFPL
# @@ReadME           :  make --help
# @@Copyright        :  Copyright: (c) 2023 Jason Hempstead, Casjays Developments
# @@Created          :  Saturday, Apr 08, 2023 18:41 EDT
# @@File             :  make
# @@Description      :  Create wordlist from the EFF words
# @@Changelog        :  New script
# @@TODO             :  Better documentation
# @@Other            :
# @@Resource         :
# @@Terminal App     :  no
# @@sudo/root        :  no
# @@Template         :  shell/sh
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
HOME="${USER_HOME:-$HOME}"
USER="${SUDO_USER:-$USER}"
RUN_USER="${SUDO_USER:-$USER}"
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Set variables
WORD_LiST="words.json"
TEXT_FILE="https://www.eff.org/files/2016/07/18/eff_large_wordlist.txt"
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Create directories

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Define variables

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Export variables

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Main application
printf '%s\n' "Creating the wordlist"
printf '{ "words": [\n' >"$WORD_LiST"
curl -q -LSsf "$TEXT_FILE" | awk '{print $2}' | sed 's|^|"|g;s|$|",|g' >>"$WORD_LiST"
printf '"end"\n]\n}\n' >>"$WORD_LiST"
test_results="$(jq -r '.words|.[]' <"$WORD_LiST" 2>/dev/null | sort -uR | head -n5|tr '\n' ' ' | grep '^')"
if [ -n "$test_results" ]; then
printf '%s\n' "$test_results"
else
printf '%s\n' "Something went wrong"
fi
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# End application
# ex: ts=2 sw=2 et filetype=sh
