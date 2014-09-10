#!/usr/bin/env zsh

# http://zsh.sourceforge.net/Doc/Release/Functions.html
#
# preexec
# Executed just after a command has been read and is about to be executed. If
# the history mechanism is active (and the line was not discarded from the
# history buffer), the string that the user typed is passed as the first
# argument, otherwise it is an empty string. The actual command that will be
# executed (including expanded aliases) is passed in two different forms: the
# second argument is a single-line, size-limited version of the command (with
# things like function bodies elided); the third argument contains the full
# text that is being executed.
#
# precmd
# Executed before each prompt. Note that precommand functions are not
# re-executed simply because the command line is redrawn, as happens, for
# example, when a notification about an exiting job is displayed.

_auto_time_limit=7
_auto_time_start_second=0
_auto_time_cmd=""

# From experimentation:
# $1 = command without aliases expanded
# $2 = command with aliases expanded
_auto_time_preexec() {
  _auto_time_start_second="$SECONDS"
  _auto_time_cmd="$2"
}

_auto_time_precmd() {
  if [[ -n "$TTY" ]] && [[ $_auto_time_start_second -gt 0 ]]; then
    local elapsed=$(($SECONDS - $_auto_time_start_second))
    if [[ $elapsed -ge $_auto_time_limit ]]; then
      echo 'cmd     ' "$_auto_time_cmd"
      echo 'elapsed ' "$elapsed"s
      echo 'idle    ' "$TTYIDLE"s
      echo 'code    ' $?
    fi
  fi
  _auto_time_start_second=0
}

add-zsh-hook precmd _auto_time_precmd
add-zsh-hook preexec _auto_time_preexec