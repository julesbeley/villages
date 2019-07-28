# overwrites bob.json at every increment
for /f "delims=" %u in (testurls.txt) do curl %u -o bob.json -g 

# bash
# set locale to C and encoding to ISO-8859-1 (Western European)
while read -r p
do 
let l++
curl "$p" -o "file$l".json -g
done<testurls.txt