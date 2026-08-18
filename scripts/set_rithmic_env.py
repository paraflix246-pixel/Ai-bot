#!/usr/bin/env python
"""Prompt for Rithmic credentials and write them into .env (never printed)."""
from __future__ import annotations

import getpass
import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
ENV_PATH = ROOT / ".env"


def set_key(text: str, key: str, value: str) -> str:
    line = f"{key}={value}"
    pattern = rf"(?m)^{re.escape(key)}=.*$"
    if re.search(pattern, text):
        return re.sub(pattern, line, text)
    return text.rstrip() + f"\n{line}\n"


def main() -> int:
    if not ENV_PATH.exists():
        print(f"[ERROR] {ENV_PATH} not found. Run setup_windows.bat first.")
        return 1

    print()
    print("Rithmic / TradeSea / Lucid login (needed for MNQ live)")
    print("Leave RITHMIC_SYSTEM blank to use LucidTrading.")
    print()
    user = input("RITHMIC_USER_ID: ").strip()
    password = getpass.getpass("RITHMIC_PASSWORD: ").strip()
    system = input("RITHMIC_SYSTEM [LucidTrading]: ").strip() or "LucidTrading"

    if not user or not password:
        print("[ERROR] User ID and password are required.")
        return 1

    text = ENV_PATH.read_text(encoding="utf-8", errors="replace")
    text = set_key(text, "BROKER_TYPE", "rithmic")
    text = set_key(text, "ASSET_CLASS", "futures")
    text = set_key(text, "RITHMIC_USER_ID", user)
    text = set_key(text, "RITHMIC_PASSWORD", password)
    text = set_key(text, "RITHMIC_SYSTEM", system)
    ENV_PATH.write_text(text, encoding="utf-8")
    print(f"Saved Rithmic login to {ENV_PATH} (password not shown).")
    return 0


if __name__ == "__main__":
    sys.exit(main())
