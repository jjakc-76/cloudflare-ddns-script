#!/bin/bash
accid='Your Cloudflare account zone id' # https://developers.cloudflare.com/fundamentals/get-started/basic-tasks/find-account-and-zone-ids/
apikey='api token key' # https://developers.cloudflare.com/fundamentals/api/get-started/create-token/
dnsrecord='the dns record that you want to change' # if you are just changing the root dns record then this will just be the domain name, e.g. example.com. for any others do test.example.com

prev=`cat wanip.txt`
dnsid=$(curl -sS -X GET "https://api.cloudflare.com/client/v4/zones/$accid/dns_records?direction=desc&name=$dnsrecord" \
		-H "Authorization: Bearer $apikey" \
                -H "Content-Type: application/json" \
                | jq -r '{"result"}[] | .[0] | .id')

cur=$(curl -sS https://ipinfo.io/ip)

if [ "$cur" != "$prev" ]
then
        {
            curl -sS -X PATCH "https://api.cloudflare.com/client/v4/zones/$accid/dns_records/$dnsid" \
                 -H "Authorization: Bearer $apikey" \
                 -H "Content-Type: application/json" \
                 --data '{"type":"A","name":"'$dnsrecord'","content":"'$cur'","ttl":1,"proxied":false}'
        }

echo "$cur" > wanip.txt

else
        :
fi