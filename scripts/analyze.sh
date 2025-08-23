#!/usr/bin/env bash
set -euo pipefail

luau-lsp analyze \
    --platform=standard \
    --settings=".vscode/settings.json" \
    src tests