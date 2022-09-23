#!/usr/bin/env bash

DEPARTING=Boston # 'Boston' or 'Provincetown'
DATE=2022-09-24
ADULTS=1
SENIORS=0
CHILDREN=0
BABIES=0
BIKES=0
LINK="https://secure.baystatecruisecompany.com/reserve"

WEBPAGE="$( curl -GLsc- -w"%{url}\n" "$LINK" \
  --data-urlencode trip_info="ferry|ow|$DEPARTING" \
  --data-urlencode departure_date="$DATE" \
  --data-urlencode adults="$ADULTS" \
  --data-urlencode seniors="$SENIORS" \
  --data-urlencode children="$CHILDREN" \
  --data-urlencode babies="$BABIES" \
  --data-urlencode bikes="$BIKES" \
  --data-urlencode submit="See+available+trips" \
)"

MESSAGE="$( echo "$WEBPAGE" \
  | grep --group-separator="<br><br>" -C0 "Fast Ferry,\|/reserve?" \
  | html2text -width 999 \
)"
KEY="$2" # You can put your key here but don't save it to a git repo
PHONE="$1"

cmp -s <( echo "$MESSAGE" ) message \
  || ( curl -X POST https://textbelt.com/text \
      --data-urlencode phone="$PHONE" \
      --data-urlencode message="$MESSAGE" \
      -d key="$KEY" \
    && echo "$MESSAGE" > message
  )

