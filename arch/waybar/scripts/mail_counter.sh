#!/bin/bash

DB_PATH="$HOME/.thunderbird/i8saxzhl.default-release/global-messages-db.sqlite"

UNREAD_COUNT=$(sqlite3 "$DB_PATH" "SELECT jsonAttributes FROM messages")

echo "$UNREAD_COUNT"