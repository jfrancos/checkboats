#!/bin/sh
DEPARTING=Provincetown # 'Boston' or 'Provincetown'
DATE=2022-09-20
ADULTS=1
SENIORS=0
CHILDREN=0
BABIES=0
BIKES=0
LINK="https://secure.baystatecruisecompany.com/reserve"

WEBPAGE="$( curl -GLsc- -w "%{url}\n" "$LINK" \
--data-urlencode trip_info="ferry|ow|$DEPARTING" \
--data-urlencode departure_date="$DATE" \
--data-urlencode adults="$ADULTS" \
--data-urlencode seniors="$SENIORS" \
--data-urlencode children="$CHILDREN" \
--data-urlencode babies="$BABIES" \
--data-urlencode bikes="$BIKES" \
--data-urlencode submit="See+available+trips" \
)"

#curl -c- -LGso /dev/null -w "%{url}\n\n" "$LINK" --data-urlencode departure_date="$DATE" --data-urlencode adults="$ADULTS"

FERRIES="$( echo "$WEBPAGE"  |  grep "Fast Ferry,\|secure.baystatecruisecompany.com/reserve?" )"
MESSAGE="$( echo "$FERRIES" | sed 's/<[^>]*>//g' | awk 1 ORS='\n\n' )"
KEY="$2" # You can put your key here but don't save it to a git repo
PHONE="$1"

#echo "$FERRIES"
#echo "$WEBPAGE"
#echo "$LINK"
echo "$MESSAGE"
#echo -e "$MESSAGE" | md5sum -c boats.md5 || curl -X POST https://textbelt.com/text --data-urlencode phone="$PHONE" --data-urlencode message="$MESSAGE" -d key="$KEY" && echo -e "$MESSAGE" | md5sum > boats.md5

