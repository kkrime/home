session_root "/Users/iraq/develop/last_calls"

if initialize_session "promo"; then

  # tmux set-environment -g LINES_ $LINES
  # tmux set-environment -g COLUMNS_ $COLUMNS

  h="LINES_=$LINES COLUMNS_=$COLUMNS "

  new_window "avd"
  run_cmd 'while :; do adb devices | rg 'emulator.*device'; [[ "$?" -eq 0 ]] && break; done && fl'
  split_h 50
  # run_cmd "/Users/iraq/Library/Android/sdk/emulator/emulator -avd Medium_Phone"
  select_pane 1

  window_root "/Users/iraq/develop/last_calls"
  new_window "flutter"
  run_cmd "$h v"

  window_root "/Users/iraq/Documents/bruno/promo/collections/Managment"
  new_window "e2e"
  run_cmd "$h v"

  window_root "/Users/iraq/develop/backend"
  new_window "backend"
  run_cmd  "$h v"

  new_window "db"
  run_cmd "$h db"

  select_window e2e
  # select_window db
fi

finalize_and_go_to_session
