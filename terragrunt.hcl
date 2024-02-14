
 "dns_rules" = { 

    "external-services-dns" = {

      capacity = 200
      domain_list = tolist(["www.google.com","www.yahoo.com","www.skyflow.com"])
      actions = "ALLOWLIST"
      protocol_list = ["TLS_SNI"]
    },
