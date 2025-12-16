# KWin Hidden Window Input Filter

**Author:** Henrique Jose de Souza  
**Contact:** henriquejsza@gmail.com  
**Year:** 2025

This patch adds a "Hidden Window Mode" to KWin, allowing you to control windows that are excluded from screen capture (screencasts) while interacting with them normally using a virtual cursor.

> [!NOTE]
> **Ethical Use & Purpose:**
> This tool is designed to enhance privacy and security during presentations by allowing users to check confidential information (e.g., password managers, private notes) without exposing sensitive data in a screen share. It is **not** intended for deceptive practices in professional environments. Please use responsibly.

## Features

- **Hidden Interaction**: Interact with windows that are invisible to screen recorders (using `excludeFromCapture`).
- **Input Redirection**: Press `F12` to freeze your visible cursor and spawn a "virtual cursor" inside the hidden window.
- **Virtual Cursor**: A software-rendered cursor appears within the hidden window, allowing you to click, type, and scroll without the real cursor moving on the recording.
- **Window Management**:
  - `Alt+D`: Global shortcut to toggle minimize/restore for the hidden window.
  - Move the hidden window by dragging its title bar while in hidden mode.

## Installation

### Prerequisites
You need the KWin source code and build dependencies.

### Applying the Patch
1. Clone KWin:
   ```bash
   git clone https://invent.kde.org/plasma/kwin.git
   cd kwin
   ```
2. Apply the patch:
   ```bash
   git apply kwin-hidden-window-feature.patch
   ```
3. Build and Install KWin (standard KDE build process):
   ```bash
   mkdir build && cd build
   cmake ..
   make -j$(nproc)
   sudo make install
   ```
   *(Note: You might need to restart KWin or your session)*

## Usage

1. **Mark a Window as Hidden**:
   - Right-click the window title bar -> "More Actions" -> "Hide from Screencast".
   - Or allow an app to set `excludeFromCapture` programmatically.

2. **Activate Control Mode**:
   - Press **F12**.
   - Your real cursor freezes.
   - A virtual cursor appears in the hidden window.
   - You can now interact with it privately.

3. **Deactivate**:
   - Press **F12** again to return control to the normal desktop.

## License

This code is part of the KDE project and is licensed under GPL-2.0-or-later.
