#!/bin/sh

set -e

OLD_NAME=$1
NEW_NAME=$2

echo Cloning $OLD_NAME with new name $NEW_NAME

OLD_APP=$OLD_NAME.app
NEW_APP=$NEW_NAME.app


cp -a $OLD_APP $NEW_APP

sed -i .bak -e "s@<string>$OLD_NAME</string>@<string>$NEW_NAME</string>@g" $NEW_APP/Contents/Info.plist



### These are all a sign of my struggle with the format of the file.
### Eventually gave up and just am directly echoing the desired
### directive.

# sed -i .bak -e "s@$OLD_NAME@$NEW_NAME@g" $NEW_APP/Contents/Resources/en.lproj/InfoPlist.strings

# sed -i .bak -e '1s/^\xef\xbb\xbf//' $NEW_APP/Contents/Resources/en.lproj/InfoPlist.strings
# sed -i .bak -e s/^\xEF\xBB\xBF// $NEW_APP/Contents/Resources/en.lproj/InfoPlist.strings

# sed -i .bak -e "s@$OLD_NAME@$NEW_NAME@g" $NEW_APP/Contents/Resources/en.lproj/InfoPlist.strings
# perl -pi -e 's/$OLD_NAME/$NEW_NAME/g' $NEW_APP/Contents/Resources/en.lproj/InfoPlist.strings

echo "CFBundleName = \"$NEW_NAME\";" > $NEW_APP/Contents/Resources/en.lproj/InfoPlist.strings
