#!/bin/sh
DATE=2022-09-20
ADULTS=1
SENIORS=0
CHILDREN=0
BABIES=0
BIKES=0
LINK="https://secure.baystatecruisecompany.com/reserve?trip_info=ferry%7Cow%7CProvincetown&departure_date=$DATE&adults=$ADULTS&seniors=$SENIORS&children=$CHILDREN&babies=$BABIES&bikes=$BIKES&submit=See+available+trips"
INDEX=$(curl -Lsc- "$LINK")
MESSAGE="$(echo "$INDEX" | grep "Fast Ferry," | sed 's/<[^>]*>//g' | awk 1 ORS='\n\n' )"$'\n'$'\n'"$LINK"
KEY="$1" # You can put your key here but don't save it to a git repo

echo "$MESSAGE"
#echo "$INDEX"
#echo "$LINK"
#echo -e "$MESSAGE" | md5sum -c boats.md5 || curl -X POST https://textbelt.com/text --data-urlencode phone='6178385268' --data-urlencode message="$MESSAGE" -d key="$KEY" && echo -e "$MESSAGE" | md5sum > boats.md5

