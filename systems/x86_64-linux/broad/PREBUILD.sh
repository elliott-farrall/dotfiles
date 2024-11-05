#!/usr/bin/env bash
set -e

SYSTEM=$(dirname $0)

# Docker Compose
$SYSTEM/services/compose.sh
