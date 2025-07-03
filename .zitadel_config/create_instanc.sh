token=`zitadel-tools key2jwt --audience=http://localhost:8080 --key=/Users/work/go/src/zitadel/internal/integration/config/system-user-with-no-permissions.pem --issuer=superuser`
echo $token
# curl -L 'http://localhost:8080/system/v1/instances/_create' \
# -H 'Content-Type: application/json' \
# -H 'Accept: application/json' \
# -d '{
#   "instanceName": "instance_name",
#   "firstOrgName": "first_org",
#   "customDomain": "first_domain",
#   "human": {
#     "userName": "human",
#     "email": {
#       "email": "human@human.com",
#       "isEmailVerified": true
#     },
#     "profile": {
#       "firstName": "string",
#       "lastName": "string",
#       "preferredLanguage": "string"
#     },
#     "password": {
#       "password": "Password!1",
#       "passwordChangeRequired": false
#     }
#   },
#   "machine": {
#     "userName": "string",
#     "name": "string",
#     "personalAccessToken": {
#       "expirationDate": "2519-04-01T08:45:00.000000Z"
#     },
#     "machineKey": {
#       "type": "KEY_TYPE_UNSPECIFIED",
#       "expirationDate": "2519-04-01T08:45:00.000000Z"
#     }
#   },
#   "defaultLanguage": "English"
# }'
curl -L 'http://localhost:8080/system/v1/instances/_create' \
-H 'Content-Type: application/json' \
-H 'Accept: application/json' \
-H "Authorization: Bearer $token" \
-d '{
  "instanceName": "instancename",
  "firstOrgName": "first_org",
  "customDomain": "iiinstance.localhost",
  "human": {
    "userName": "instance",
    "email": {
      "email": "human@human.com",
      "isEmailVerified": true
    },
    "profile": {
      "firstName": "string",
      "lastName": "string",
      "preferredLanguage": "string"
    },
    "password": {
      "password": "Password!1",
      "passwordChangeRequired": false
    }
  },
  "defaultLanguage": "English"
}'
