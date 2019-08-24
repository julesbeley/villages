# bash
# set locale to C and encoding to ISO-8859-1 (Western European)
l=0
while IFS=$' \t\n\r' read -r p
do 
let l++
curl "$p" -f -o "file$l.json" -g
done<testurls.txt
del=$(find . -name "file*.json" -size 338c -type f -printf '.' | wc -c)
read -r -p "Delete $del empty files? [y/n]" response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])+$ ]]
then
find . -name "file*.json" -size 338c -delete
out=$(find . -name "file*.json" -type f -printf '.' | wc -c) 
echo "There are $out files"
fi
