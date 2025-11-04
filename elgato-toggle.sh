#!/bin/bash

# =============================================================================
#         Elgato Key Light Toggle Script
# =============================================================================
#
# This script toggles your Elgato Key Light on or off by checking its
# current state via the REST API and sending the opposite command.
#

# --- BEGIN CONFIGURATION ---

# 1. Find your Key Light Air's IP address.
#    You can find this in your Wi-Fi router's admin panel. Look for a
#    device named "Elgato Key Light Air" or similar in the list of
#    connected devices.
#
# 2. (Recommended) Set a static IP or DHCP reservation for your light
#    in your router's settings. This ensures the IP address never
#    changes, so your script will always work.
#
# 3. Replace the IP address below with your light's IP address.
LIGHT_IP="192.168.1.13"

# --- END CONFIGURATION ---


# Construct the API URL
BASE_URL="http://${LIGHT_IP}:9123/elgato/lights"
CONTENT_TYPE="Content-Type: application/json"
DATA_OFF='{"lights":[{"on":0}]}'
DATA_ON='{"lights":[{"on":1}]}'

# Check the light's current state.
# We use:
#   -s : Silent mode (no progress meter)
#   -f : Fail silently (return non-zero exit code on HTTP error)
#   -m 3 : Max time of 3 seconds for the operation
#elgat.
# We pipe the JSON output to `grep -q` to quietly search for '"on":1'.
# `grep -q` returns an exit code of 0 if it finds the string, and 1 if not.
if curl -s -f -m 3 "$BASE_URL" | grep -q '"on":1'; then
    # If found (exit code 0), the light is ON. Send the OFF command.
    echo "Light is ON. Turning OFF."
    curl -s -X PUT -H "$CONTENT_TYPE" -d "$DATA_OFF" "$BASE_URL"
else
    # If not found (exit code 1), the light is OFF. Send the ON command.
    echo "Light is OFF. Turning ON."
    curl -s -X PUT -H "$CONTENT_TYPE" -d "$DATA_ON" "$BASE_URL"
fi

# We add a small exit 0 to ensure Automator is always happy.
exit 0

# =============================================================================
#         HOW TO USE THIS SCRIPT WITH A KEYBOARD SHORTCUT (macOS)
# =============================================================================
#
# ### Part 1: Make the Script Executable (Do this once)
#
# 1. Save this file as `toggle-key-light.sh` in your home folder.
# 2. Open the Terminal app.
# 3. Run this command to make the script runnable:
#    chmod +x ~/toggle-key-light.sh
#
# ### Part 2: Create a macOS "Quick Action"
#
# 1. Open the **Automator** app.
# 2. Click **New Document** -> **Quick Action** -> **Choose**.
# 3. At the top, set "Workflow receives current" to **no input**.
# 4. Find the **"Run Shell Script"** action and drag it into the workflow.
# 5. In the script box, replace `YOUR_USERNAME` with your Mac's username:
#    /bin/bash /Users/YOUR_USERNAME/toggle-key-light.sh
# 6. Go to **File > Save** and name it something like `Toggle Key Light`.
#
# ### Part 3: Assign a System-Wide Keyboard Shortcut
#
# 1. Open **System Settings** > **Keyboard** > **Keyboard Shortcuts...**.
# 2. Select **Services** from the side menu.
# 3. Scroll to the **General** section and find your **"Toggle Key Light"** action.
# 4. Click it and select **"Add Shortcut"**.
# 5. Press a unique key combo (e.g., ^ + ⌥ + ⌘ + L).
#
# ### Part 4: Link to Logitech MX Keys (or other device)
#
# 1. Open the **Logi Options+** app.
# 2. Select your keyboard and choose the key you want to program.
# 3. Assign it the **"Keyboard Shortcut"** action.
# 4. When prompted, press the exact key combo you just created in Part 3.
#