read -p "Endpoint (e.g 12.12.12.12:51820): " endpoint

[[ "$endpoint" =~ :[0-9]?*$ ]] && endpoint="$endpoint" || endpoint="$endpoint:51820"
echo "$endpoint"


exit 0
