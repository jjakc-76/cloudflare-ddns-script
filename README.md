# cloudflare-ddns-script
Script to update cloudflare dns record for a WAN ip change. Useful if one has a residential dynamic ip.

It requires [jq](https://stedolan.github.io/jq/) to parse the json response from cloudflare api and grab the dns record id. 
