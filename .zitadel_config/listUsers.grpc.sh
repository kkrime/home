# super user
token=`zitadel-tools key2jwt --audience=http://localhost:8080 --key=/Users/work/go/src/zitadel/internal/integration/config/system-user-with-no-permissions.pem --issuer=superuser`
# echo $token

# zitadel
# token=lLGWGTxweeEEKbfE-SMmeGwXJD4YYhtmDdtDRIQ-Iam6MsaQWosEDRbXuEraYo8inUGLuECjR3BA8y7nPGwbwnRZ1wtzHNWJ_ROdQMxR

set v2 feature falg
grpcurl -plaintext -H "Authorization: Bearer $token"  -d '{
  "improvedPerformance": [],
  "permissionCheckV2": true
}' localhost:8080 zitadel.feature.v2.FeatureService.SetInstanceFeatures


# grpcurl  -plaintext  -H "Authorization: Bearer $token" -d '{
#   "queries": []
# }' localhost:8080  zitadel.user.v2.UserService.ListUsers


echo ###########################################################################################################
echo ###########################################################################################################
echo ###########################################################################################################
echo ###########################################################################################################
echo ###########################################################################################################

# grpcurl  -plaintext  -H "Authorization: Bearer $token" \
#   -d '{
# }' localhost:8080 zitadel.user.v2.UserService.ListUsers
# }' instance.localhost:8080 zitadel.user.v2.UserService.ListUsers



# grpcurl  -plaintext  -H "Authorization: Bearer $token" \
#   -H 'x-zitadel-orgid: 310716990375453665' \
#   -d '{
# "queries": [
#     {
#       "organizationIdQuery": {
#         "organizationId": "310716990375453665"
#       }
#     }
#   ]
# }' instance.localhost:8080 zitadel.user.v2.UserService.ListUsers
# }' localhost:8080 zitadel.user.v2.UserService.ListUsers


  # -H 'x-zitadel-orgid: 312577220151411135' \
# grpcurl  -plaintext  -H "Authorization: Bearer $token" \
#   -d '{
# }' instance.localhost:8080 zitadel.user.v2.UserService.ListUsers
# }' localhost:8080 zitadel.user.v2.UserService.ListUsers
#
#
#
# grpcurl  -plaintext  -H "Authorization: Bearer $token" \
#   -H 'x-zitadel-orgid: 310716990375453665' \
#   -d '{
# "queries": [
#     {
#       "organizationIdQuery": {
#         "organizationId": "310716990375453665"
#       }
#     }
#   ]
# }' localhost:8080 zitadel.user.v2.UserService.ListUsers
# }' instance.localhost:8080 zitadel.user.v2.UserService.ListUsers


# grpcurl  -plaintext  -H "Authorization: Bearer $token" \
#   -H 'x-zitadel-orgid: 310716990375453665' \
#   -d '{
# }' localhost:8080 zitadel.user.v2.UserService.ListUsers
# }' instance.localhost:8080 zitadel.user.v2.UserService.ListUsers

grpcurl  -plaintext  -H "Authorization: Bearer $token" \
  -H 'x-zitadel-orgid: 310716990375453665' \
  -d '{
"queries": [
    {
      "organizationIdQuery": {
        "organizationId": "310716990375453665"
      }
    }
  ]
}' localhost:8080 zitadel.user.v2.UserService.ListUsers
# }' instance.localhost:8080 zitadel.user.v2.UserService.ListUsers
