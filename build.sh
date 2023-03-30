#!/bib/bash
sed -e "s/VERSION/$1/g" src/header.txt > dist/header.txt
