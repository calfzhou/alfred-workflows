#!/usr/bin/env bash

query="$@"

if [[ "$query" == "" ]]; then
    answer=
    title='Calculate using Qalculate!'
    subtitle='Open Qalculate! or type mathematical expression to get result'
else
    PATH=/usr/local/bin:"$PATH"
    answer="$(qalc -t "$query")"
    title="$answer"
    subtitle="Action to copy to clipboard, ⌘⏎ to open Qalculate!"
fi

function dequote() {
    echo "$@" | sed 's/"/\\"/g'
}

cat << EOB
{
    "items": [{
        "uid": "$(dequote $query)",
        "type": "file",
        "title": "$(dequote $title)",
        "subtitle": "$(dequote $subtitle)",
        "autocomplete": "$(dequote $query)",
        "arg": "$(dequote $answer)",
        "autocomplete": "$(dequote $query)"
    }]
}
EOB
