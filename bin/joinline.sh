#!/bin/bash
#
# joinline.sh — Join clipboard text into a single line.
#
# Reads the macOS clipboard, replaces newlines with spaces, collapses runs of
# whitespace into one space, trims leading/trailing spaces, and writes the
# result back to the clipboard.
#
# Usage:
#   ./joinline.sh             # transform the clipboard in place (default)
#   echo "foo\nbar" | ./joinline.sh --stdin   # transform stdin, print to stdout
#
# Hook it up to an Alfred "Run Script" action (no argument) or a macOS Quick
# Action. Default behavior writes the result back to the clipboard so you can
# paste immediately.

set -euo pipefail

join_lines() {
  tr '\n' ' ' | sed -E 's/[[:space:]]+/ /g; s/^ +| +$//g'
}

if [ "${1:-}" = "--stdin" ]; then
  # Pipe mode: read stdin, print to stdout.
  join_lines
else
  # Default: operate on the clipboard.
  pbpaste | join_lines | pbcopy
fi
