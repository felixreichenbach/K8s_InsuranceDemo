#!/bin/bash

# Change MongoDB Connection String and Escape \/ and \&!
replace_str='"mongodb:\/\/demo:demo@sandbox-shard-00-00-afb5d.mongodb.net:27017,sandbox-shard-00-01-afb5d.mongodb.net:27017,sandbox-shard-00-02-afb5d.mongodb.net:27017\/test?ssl=true\&replicaSet=Sandbox-shard-0\&authSource=admin\&retryWrites=true"'

search_str='"mongodb:\/\/localhost:27017\/"'

sed -i 's/'"$search_str"'/'"$replace_str"'/g' car_insurance_policies_cdc.json

sed -i 's/'"$search_str"'/'"$replace_str"'/g' car_insurance_customers_cdc.json

sed -i 's/'"$search_str"'/'"$replace_str"'/g' home_insurance_policies_cdc.json

sed -i 's/'"$search_str"'/'"$replace_str"'/g' home_insurance_customers_cdc.json