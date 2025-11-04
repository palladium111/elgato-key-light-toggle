# Elgato Key Light Toggle Script (macOS)

A simple bash script to toggle an Elgato Key Light on or off via its local REST API.

This script is designed to be tied to a global keyboard shortcut on macOS, allowing you to control your light with a single keypress from any application. It's perfect for use with customizable keyboards like the Logitech MX Keys.

## Features

- **Smart Toggling:** Checks the light's current state (on/off) and sends the opposite command.
- **Lightweight:** No dependencies required other than `curl`, which is built into macOS.
- **Fast:** Uses local API calls for near-instant response.
- **Easy Setup:** Can be linked to any key using macOS's built-in Automator and System Settings.

## Setup Instructions

### Step 1: Configure the Script

1. **Find Your Light's IP:** Log in to your Wi-Fi router's admin panel and look for your "Elgato Key Light Air" in the list of connected devices. Note its IP address.
2. **Set a Static IP (Recommended):** In your router's settings, find the "DHCP Reservation" or "Static IP" feature. Assign a permanent IP address to your light. This ensures the script won't break if the light's IP changes.
3. **Edit the Script:** Open `toggle-key-light.sh` and change the `LIGHT_IP` variable to your light's static IP address.
	```
	LIGHT_IP="192.168.1.101" # <-- Change this to your light's IP
	```

### Step 2: Make the Script Executable

Before macOS will run the script, you must give it "execute" permissions.

1. Save the `toggle-key-light.sh` script to your home folder (`/Users/YOUR_USERNAME/`).
2. Open the **Terminal** app.
3. Run the following command:
	```
	chmod +x ~/toggle-key-light.sh
	```

### Step 3: Create a macOS "Quick Action"

We will use the built-in **Automator** tool to create a system service that runs this script.

1. Open **Automator** (you can find it with Spotlight, `Cmd+Space`).
2. Select **New Document** -> **Quick Action** -> **Choose**.
3. At the top of the workflow panel, set the dropdowns to:
	- "Workflow receives current" -> **no input**
	- "in" -> **any application**
4. In the Actions library on the left, search for **"Run Shell Script"** and drag it into the workflow panel on the right.
5. In the "Run Shell Script" box, replace `YOUR_USERNAME` with your Mac's short username (the name of your home folder):
	```
	/bin/bash /Users/YOUR_USERNAME/toggle-key-light.sh
	```
6. Go to **File > Save** and name your Quick Action something simple, like `Toggle Key Light`.

### Step 4: Assign a System-Wide Keyboard Shortcut

Now, we'll assign a key combo to the Quick Action you just created.

1. Open **System Settings** > **Keyboard**.
2. Click the **Keyboard Shortcuts...** button.
3. In the new window, select **Services** from the left-hand menu.
4. Scroll down the list on the right to the **General** section. You will see your Quick Action: **"Toggle Key Light"**.
5. Click on it, then click the **"Add Shortcut"** button.
6. Press a unique key combination that other apps don't use (e.g., `⌃ + ⌥ + ⌘ + L`).
7. Close the System Settings. Your shortcut is now active!

### Step 5: Link to Your Logitech MX Keys (Optional)

This is the final step to tie it all together.

1. Open the **Logi Options+** app.
2. Select your **MX Keys** keyboard.
3. Click on the key you want to use (e.g., the `Lock` key or `F12`).
4. In the "Action" panel, click **"Keyboard Shortcut"**.
5. A box will appear. Simply press the exact key combination you created in Step 4 (e.g., `⌃ + ⌥ + ⌘ + L`).

You're all set! Pressing that key on your keyboard will now toggle your Elgato Key Light.