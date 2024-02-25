run_hostap() {
  cd /home/aa/friFi/hostap/hostapd && sudo ./start.sh
}

alias hostap='run_hostap'

run_free_radius() {
  cd /home/aa/friFi/freeRadius/ &&  ./start.sh
}

alias radius='run_free_radius'

alias coova='cd /home/aa/friFi/coova1/'
alias chilli='cd /home/aa/friFi/coova-chilli/'

alias tes='cd ~/friFi/testing/docker && ./run.sh'

alias dev='cd ~/friFi/dev'
