#!/bin/bash

curl --silent --request POST --url 'https://staging-mspp-service.bachcare.co.nz/auth/sessions' --header 'Content-Type: application/json' --header 'Origin: https://staging-mspp-service.bachcare.co.nz' --data "{\"email\": \"$1\",\"password\": \"$2\"}" 2>&1 | jq -r .data.jwt | cut -d '.' -f 2 | base64 --decode | sed -E -e 's/.*id_token":"([^"]+)".*/\1/' | pbcopy

echo "Supplier JWT copied to clipboard!"
