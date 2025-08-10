function zsetup() {
  cp ~/.zitadel_config/.env .
  cp ~/.zitadel_config/defaults.yaml cmd/
  cp ~/.zitadel_config/docker-compose.yaml .
  cp ~/.zitadel_config/steps.yaml cmd/setup/
  cp ~/.zitadel_config/run.sh .
  # cp ~/.zitadel_config/exclude ~/go/src/zitadel_bare/info
  cp ~/.zitadel_config/Makefile .
  # cp ~/.zitadel_config/exclude .git/info
}

# alias za='cd ~/go/src/z1'
alias zz='cd ~/go/src/z1'
