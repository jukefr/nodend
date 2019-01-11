#!/usr/bin/env bash

echo "⚙  Gitting..."
git checkout master &>/dev/null
git rebase HEAD master &>/dev/null
git pull https://"$GIT_USER":"$GIT_PW"@github.com/"$GIT_USER"/nodend.git master &>/dev/null


echo "⚙  Installing node modules..."
npm i -g html-minifier uglify-js clean-css &>/dev/null

# Build
echo "⚙  Building..."
hugo --cleanDestinationDir &>/dev/null

EVERYTHING=$(find docs/ -type f -name "*.html*" -o -name "*.json*" -o -name "*.xml*" )
for FILE in $EVERYTHING
do
    echo "⚡ Cleaning" $FILE
    html-minifier $FILE --minify-js --minify-css --collapse-whitespace --remove-comments --remove-empty-attributes --remove-redundant-attributes --remove-script-type-attributes --remove-style-link-type-attributes -o $FILE
done

echo "⚙  Setting CNAMEs..."
printf "nodend.com\nwww.nodend.com" > docs/CNAME

echo "⚙  Gitting..."
git config user.email "netlify@netlify.com" &>/dev/null
git config user.name "Netlify" &>/dev/null
git add docs/ &>/dev/null
git commit -m "netlify build" &>/dev/null
git pull https://"$GIT_USER":"$GIT_PW"@github.com/"$GIT_USER"/nodend.git master &>/dev/null
git push https://"$GIT_USER":"$GIT_PW"@github.com/"$GIT_USER"/nodend.git master &>/dev/null

echo "✔  Done."
