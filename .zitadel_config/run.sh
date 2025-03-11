docker ps | rg "zitadel.*db"  > /dev/null || echo "not running starting" && docker compose up db --detach 
# source .env && go run . start-from-init --masterkey "MasterkeyNeedsToHave32Characters" --tlsMode disabled
source .env && go build . && ./zitadel start-from-init --masterkey "MasterkeyNeedsToHave32Characters" --tlsMode disabled
