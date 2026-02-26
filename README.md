# 👻 GhostCursor

*A Native Swift Utility That Haunts Your Mouse So You Don't Have To*

---

## Overview

GhostCursor is a lightweight command-line utility written in Swift that periodically moves the mouse cursor by small, random amounts. It runs natively on macOS without any third-party dependencies, leveraging Apple's CoreGraphics framework to simulate natural-looking mouse activity.

---

## Setup Instructions

### Prerequisites

- macOS 10.15 (Catalina) or later
- Swift runtime (included with macOS by default)
- Accessibility permissions granted to Terminal (or your preferred terminal app)

### Step-by-Step

1. **Save the script** as `ghostcursor.swift` in any directory.
2. **Make it executable:** `chmod +x ghostcursor.swift`
3. **Run the script:** `swift ghostcursor.swift`
4. **Grant Accessibility access** when prompted. Navigate to System Settings → Privacy & Security → Accessibility and enable your terminal application.
5. **Stop the script** at any time by pressing `Ctrl+C` in the terminal.


---

## How It Works

GhostCursor operates in a continuous loop and performs the following steps on each cycle:

1. **Reads the current mouse position** using `CGEvent` to query the system for the cursor's exact coordinates on screen.
2. **Calculates a random offset** between −80 and +80 pixels in both the X and Y axes, creating a subtle, natural-looking movement.
3. **Clamps the new position** to stay within screen bounds so the cursor never moves off-screen.
4. **Posts a CGEvent mouse-move event** to the system event tap, which macOS interprets as genuine user activity.
5. **Sleeps for 15–45 seconds** (randomized each cycle) before repeating. The randomized interval makes the activity pattern look human rather than robotic.

---

## Code Breakdown

### Key Components

| Component | Description |
|---|---|
| **CoreGraphics** | Apple's low-level graphics framework used to read and post mouse events at the system level. |
| **CGEvent** | Represents a system-level input event. Used to both query current mouse position and generate new mouse-move events. |
| **CGDisplayPixelsWide/High** | Queries the main display resolution to ensure the cursor stays within screen bounds. |
| **Int.random(in:)** | Swift's built-in random number generator used to produce natural, unpredictable movement offsets and sleep intervals. |
| **signal(SIGINT)** | Captures the Ctrl+C interrupt signal for a clean exit with a goodbye message instead of an abrupt termination. |

---

## Configuration Parameters

The following values can be adjusted directly in the script to tailor behavior:

| Parameter | Default | Purpose |
|---|---|---|
| Movement range | ±80 px | How far the cursor moves per cycle. Smaller values are subtler; larger values are more noticeable. |
| Sleep interval | 15–45 sec | Time between movements. Most apps timeout after 5 minutes, so anything under 5 min works. |
| Screen margin | 10 px | Buffer from screen edge to prevent the cursor from getting stuck in corners. |

---

## Use Cases

### 1. Preventing Screen Lock and Sleep

Many organizations enforce screen lock policies (e.g., lock after 5 or 10 minutes). The simulated mouse activity prevents macOS from triggering the screensaver or sleep timer, keeping your desktop visible and accessible.

### 2. Long-Running Tasks and Monitoring

When monitoring dashboards, running long builds, or watching live streams on your workstation, GhostCursor prevents the display from dimming or the session from locking, so you don't miss visual updates.

### 3. Remote Desktop and VPN Sessions

Some VPN and remote desktop solutions disconnect after idle timeouts. Continuous mouse activity helps maintain these sessions, especially useful when downloading large files or waiting on remote processes.

---
