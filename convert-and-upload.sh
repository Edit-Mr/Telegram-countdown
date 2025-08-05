#!/bin/bash
set -e

IMG="banner.jpg"
OUT="output.jpg"

# Progress calculation
TODAY=$(TZ=Asia/Taipei date +%s)
START_TIMESTAMP=$(date -d "$START_DATE" +%s)
TARGET_TIMESTAMP=$(date -d "$TARGET_DATE" +%s)

TOTAL=$(( (TARGET_TIMESTAMP - START_TIMESTAMP) / 86400 ))
LEFT=$(( (TARGET_TIMESTAMP - TODAY) / 86400 ))
DAYS_DONE=$(( TOTAL - LEFT ))
PERCENT=$(( 100 * DAYS_DONE / TOTAL ))

if [ "$TOTAL" -le 0 ]; then
  echo "ERROR: Invalid date range"
  exit 1
fi

PERCENT=$(( 100 * DAYS_DONE / TOTAL ))
if [ "$PERCENT" -gt 100 ]; then PERCENT=100; fi
if [ "$PERCENT" -lt 0 ]; then PERCENT=0; fi

echo "Progress: $DAYS_DONE/$TOTAL days ($PERCENT%)"

# Image size
HEIGHT=$(identify -format "%h" "$IMG")
WIDTH=$(identify -format "%w" "$IMG")

# Split point (in pixels)
COLOR_HEIGHT=$(( HEIGHT * PERCENT / 100 ))

# Process image
magick "$IMG" \
  -gravity North -crop "${WIDTH}x$(( HEIGHT - COLOR_HEIGHT ))+0+0" +repage \
  -colorspace Gray "top.jpg"

magick "$IMG" \
  -gravity South -crop "${WIDTH}x${COLOR_HEIGHT}+0+0" +repage \
  "bottom.jpg"

magick top.jpg bottom.jpg -append "$OUT"

TITLE="SITCON 2026 工人大群 | 倒數 $LEFT 天"

curl -s -X POST https://api.telegram.org/bot${{ secrets.TELEGRAM_BOT_TOKEN }}/setChatTitle \
  -d chat_id=${{ secrets.TELEGRAM_CHAT_ID }} \
  -d title="$TITLE"

# Upload
curl -s -X POST "https://api.telegram.org/bot$BOT_TOKEN/setChatPhoto" \
  -F chat_id="$CHAT_ID" \
  -F photo=@"$OUT"
