#!/usr/bin/env bash

set -euo pipefail

notify() {
  notify-send "$1"
}

copy() {
  printf '%s' "$1" | wl-copy --type 'text/plain;charset=utf-8'
}

expand_home() {
  local p=${1/#\~\//$HOME/}
  printf '%s' "$p"
}

encrypt() {
  local text output answer

  text=$(printf '' | rofi -theme purple -dmenu -p 'Text to encrypt' -theme-str 'window {width: 20%; height: 3%; padding: 5px;} listview {lines: 1;}') || exit 0
  [[ -n "$text" ]] || exit 0

  output=$(printf '' | rofi -theme purple -dmenu -p 'Output' -mesg 'Empty: copy to clipboard' -theme-str 'window {width: 20%; height: 5%; padding: 5px;} listview {lines: 1;}') || exit 0

  if [[ -z "$output" ]]; then
    encrypted=$(printf '%s' "$text" | gpg --batch --yes --symmetric --armor) ||
      { notify 'encryption failed'; exit 1; }

    copy "$encrypted"
    notify 'encrypted message copied to clipboard'
    return
  fi

  output=$(expand_home "$output")
  [[ "$output" == /* ]] || output=$HOME/$output

  mkdir -p "$(dirname "$output")"

  if [[ -e "$output" ]]; then
    answer=$(printf 'No\nYes' | rofi -theme purple -dmenu -p "Overwrite $output?" -theme-str 'window {width: 30%; height: 3%; padding: 5px;} listview {lines: 1;}') || exit 0
    [[ "$answer" == "Yes" ]] || exit 0
  fi

  printf '%s' "$text" | gpg --batch --yes --symmetric --armor --output "$output" ||
    { notify 'encryption failed'; exit 1; }

  notify "encrypted message saved to $output"
}

decrypt() {
  local clip input plaintext

  clip=$(wl-paste 2>/dev/null) || { notify 'no text in clipboard'; exit 1; }
  [[ -n "$clip" ]] || { notify 'no text in clipboard'; exit 1; }

  input=$(expand_home "$clip")

  if [[ -f "$input" ]]; then
    plaintext=$(gpg --batch --yes --decrypt "$input") ||
      { notify 'decryption failed'; exit 1; }
  else
    plaintext=$(printf '%s' "$clip" | gpg --batch --yes --decrypt) ||
      { notify 'decryption failed'; exit 1; }
  fi

  copy "$plaintext"
  notify 'decrypted message copied to clipboard'
}

case "${1:-e}" in
  e | -e | encrypt) encrypt ;;
  d | -d | decrypt) decrypt ;;
  *) notify 'usage: encrypt.sh [d|e]'; exit 1 ;;
esac
