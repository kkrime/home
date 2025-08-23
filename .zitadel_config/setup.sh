function zsetup() {
  cp ~/.zitadel_config/.env .
  # cp ~/.zitadel_config/defaults.yaml cmd/
  cp ~/.zitadel_config/docker-compose.yaml .
  # cp ~/.zitadel_config/steps.yaml cmd/setup/
  cp ~/.zitadel_config/run.sh .
  # cp ~/.zitadel_config/exclude ~/go/src/zitadel_bare/info
  # cp ~/.zitadel_config/Makefile .
  # cp ~/.zitadel_config/exclude .git/info
}

function ztest() {
  docker stop $(docker ps -a -q) && kill `pidof zitadel` ; make core_integration_db_up && echo "zitadel" > /tmp/zitadel_db && make core_integration_server_start
}

# alias za='cd ~/go/src/z1'
alias zz='cd ~/go/src/z1'
