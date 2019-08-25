# set locale to C and encoding to ISO-8859-1 (Western European)
# sed -i 's/\r$//' curl.sh before running (dos2unix)
cd data && {
l=1
while IFS=$' \t\n\r' read -r p; do 
    curl --silent "$p" -f -o "file$l.json" -g
    let l++
    done<allurls.txt
del=$(find . -name "file*.json" -size 338c -type f -printf '.' | wc -c)
if [[ "$del" -gt "0" ]]; then
    read -r -p "Delete $del empty files? [y/n] " response
    if [[ "$response" =~ ^([yY][eE][sS]|[yY])+$ ]]; then
        find . -name "file*.json" -size 338c -delete
    fi
fi
out=$(find . -name "file*.json" -type f -printf '.' | wc -c) 
echo "There are $out files"
find . -name "*.txt" -delete
jq -s '[.[][]]' *.json > all.json
cd -;}