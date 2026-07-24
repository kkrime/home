# Set window root path. Default is `$session_root`.
# Must be called before `new_window`.
#window_root "~/Projects/my-awesome-window"

# Create new window. If no argument is given, window name will be based on
# layout file name.
#
session_root "/Users/iraq/develop/last_calls"

if initialize_session "promo"; then

  new_window "avd"
  run_cmd "sleep 5"
  run_cmd "fl"
  split_h 50
  run_cmd "/Users/iraq/Library/Android/sdk/emulator/emulator -avd Medium_Phone"

  window_root "/Users/iraq/develop/last_calls"
  new_window "flutter"
  run_cmd "v ."
  # run_cmd "v --clean -S /tmp/session"

  window_root "/Users/iraq/Documents/bruno/promo/collections/Managment"
  new_window "e2e"
  run_cmd "v ."

  window_root "/Users/iraq/develop/backend"
  new_window "backend"
  run_cmd "v ."

  new_window "db"
  run_cmd "db"

  # select_window backend
  # select_window flutter
  select_window e2e
  # select_window avd
fi

finalize_and_go_to_session

# Split window into panes.
#split_v 20
#split_h 50

# Run commands.
#run_cmd "top"     # runs in active pane
#run_cmd "date" 1  # runs in pane 1

# Paste text
#send_keys "top"    # paste into active pane
#send_keys "date" 1 # paste into pane 1

# Set active pane.
#select_pane 0
