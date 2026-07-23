#!/usr/bin/env sh
set -eu

GRADLE_VERSION="8.10.2"
PROJECT_DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
DIST_DIR="$PROJECT_DIR/.gradle-dist"
GRADLE_HOME="$DIST_DIR/gradle-$GRADLE_VERSION"
ZIP_FILE="$DIST_DIR/gradle-$GRADLE_VERSION-bin.zip"
URL="https://services.gradle.org/distributions/gradle-$GRADLE_VERSION-bin.zip"

if [ ! -x "$GRADLE_HOME/bin/gradle" ]; then
  mkdir -p "$DIST_DIR"
  echo "Downloading Gradle $GRADLE_VERSION..."
  if command -v curl >/dev/null 2>&1; then
    curl -fL "$URL" -o "$ZIP_FILE"
  elif command -v wget >/dev/null 2>&1; then
    wget -O "$ZIP_FILE" "$URL"
  else
    echo "Error: curl or wget is required for the first run." >&2
    exit 1
  fi

  if command -v unzip >/dev/null 2>&1; then
    unzip -q -o "$ZIP_FILE" -d "$DIST_DIR"
  else
    echo "Error: unzip is required for the first run." >&2
    exit 1
  fi
fi

exec "$GRADLE_HOME/bin/gradle" "$@"
