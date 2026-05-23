export JAVA_HOME=$(/usr/libexec/java_home -v"17");

export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/platform-tools

alias flu="cd /Users/iraq/develop/last_calls"
alias ba="cd /Users/iraq/develop/backend"
# alias fu='killall entr && echo stopped && $(fd '.dart$' lib |   entr -p kill -USR1 $(cat /tmp/flutter.pid)) & && flutter run --pid-file /tmp/flutter.pid'
set -m
alias fl='echo start && killall entr  && $(fd '.dart$' lib |  entr -n -p kill -USR1 $(cat /tmp/flutter.pid)) &
echo stopped  && flutter run --pid-file /tmp/flutter.pid'

# Start Android Emulator
# /Users/iraq/Library/Android/sdk/emulator/emulator -avd Medium_Phone
