#!/bin/bash
set -e

IMG="banner.jpg"
OUT="output.jpg"

# Progress calculation
TODAY=$(TZ=Asia/Taipei date +%s)
TARGET=$(date -d "$TARGET_DATE" +%s)
TOTAL=$(( (TARGET - START_DATE) / 86400 ))
LEFT=$(( (TARGET - TODAY) / 86400 ))
DAYS_DONE=$(( TOTAL - LEFT ))
PERCENT=$(( 100 * DAYS_DONE / TOTAL ))

# Image size
HEIGHT=$(identify -format "%h" "$IMG")
WIDTH=$(identify -format "%w" "$IMG")

# Split point (in pixels)
COLOR_HEIGHT=$(( HEIGHT * PERCENT / 100 ))

# Process image
convert "$IMG" \
  -gravity North -crop "${WIDTH}x$(( HEIGHT - COLOR_HEIGHT ))+0+0" +repage \
  -colorspace Gray "top.jpg"

convert "$IMG" \
  -gravity South -crop "${WIDTH}x${COLOR_HEIGHT}+0+0" +repage \
  "bottom.jpg"

convert top.jpg bottom.jpg -append "$OUT"

# Upload
curl -s -X POST "https://api.telegram.org/bot$BOT_TOKEN/setChatPhoto" \
  -F chat_id="$CHAT_ID" \
  -F photo=@"$OUT"
