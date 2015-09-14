#!/bin/bash

output=$(sudo namedctl test)
result=$?

if [[ $result -eq 0 ]]; then
   echo "Status: 200 OK"
else
   echo "Status: 503 Service unavailable"
fi

echo "Content-type: text/plain"
echo
echo "$output"
