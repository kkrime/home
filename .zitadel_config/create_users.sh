token=`zitadel-tools  key2jwt --audience=http://localhost:8080 --key=internal/integration/config/system-user-with-no-permissions.pem --issuer=superuser`
echo $token

echo


# grpcurl -plaintext -H "Authorization: Bearer $token"  -d '{
#   "metadata": [],
#   "idpLinks": [],
#   "organization": {
#     "orgId": "314780636688679259"
#   },
#   "email": {
#     "email": "user-test1@zitadel.com",
#     "isVerified": true
#   },
#   "password": {
#     "password": "Password1!",
#     "changeRequired": false
#   },
#   "profile": {
#     "givenName": "test",
#     "familyName": "test",
#     "displayName": "test1"
#   }
# }' localhost:8080 zitadel.user.v2.UserService.AddHumanUser


for i in {5..8000} 
# for i in 9003
do
  echo '>>>>>>>>>>>>>' $i
  grpcurl -plaintext -H "Authorization: Bearer $token"  -d '{
    "metadata": [],
    "idpLinks": [],
    "organization": {
      "orgId": "314780636688679259"
    },
    "email": {
      "email": "'user-test$i@zitadel.com'",
      "isVerified": true
    },
    "password": {
      "password": "Password1!",
      "changeRequired": false
    },
    "profile": {
      "givenName": "test",
      "familyName": "test",
      "displayName": "test"
    }
  }' localhost:8080 zitadel.user.v2.UserService.AddHumanUser &

done

