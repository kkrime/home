docker ps | rg "zitadel.*db"  > /dev/null || echo "not running starting" && docker compose up db --detach 
# source .env && go build . && ./zitadel start-from-init --masterkey "MasterkeyNeedsToHave32Characters" --tlsMode disabled
source .env && echo && echo "Database:" $zdb && echo && echo $zdb > /tmp/zitadel_db 
go build . && ./zitadel start-from-init --masterkey "MasterkeyNeedsToHave32Characters" --tlsMode disabled
# source .env && go build cmd/zitadel/main.go && ./zitadel start-from-init --masterkey "MasterkeyNeedsToHave32Characters" --tlsMode disabled

