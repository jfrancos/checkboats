#!/bin/sh
LINKWITHBIKE='https://secure.baystatecruisecompany.com/reserve?trip_info=ferry%7Cow%7CProvincetown&departure_date=2022-09-18&adults=1&seniors=0&children=0&babies=0&bikes=1&submit=See+available+trips'
LINK='https://secure.baystatecruisecompany.com/reserve?trip_info=ferry%7Cow%7CProvincetown&departure_date=2022-09-18&adults=1&seniors=0&children=0&babies=0&bikes=0&submit=See+available+trips'
INDEX=$(curl -Lsc cookie "$LINK")
MESSAGE="$(echo "$INDEX" | grep "Fast Ferry, Sun Sep 18, 2022" | sed 's/<[^>]*>//g' | awk 1 ORS='\n\n' )"$'\n'$'\n'"$LINKWITHBIKE"
KEY=[PRIVATE KEY FROM textbelt.com]

#echo "$MESSAGE"

echo -e "$MESSAGE" | md5sum -c boats.md5 || curl -X POST https://textbelt.com/text --data-urlencode phone='6178385268' --data-urlencode message="$MESSAGE" -d key="$KEY" && echo -e "$MESSAGE" | md5sum > boats.md5

