#!/usr/bin/env swift

import Foundation
import CoreGraphics

print("👻 GhostCursor - Your mouse moves on its own")
print("   Press Ctrl+C to stop\n")

signal(SIGINT) { _ in
    print("\n👻 GhostCursor vanished. Goodbye!")
    exit(0)
}

let screenWidth = Int(CGDisplayPixelsWide(CGMainDisplayID()))
let screenHeight = Int(CGDisplayPixelsHigh(CGMainDisplayID()))

print("   Screen: \(screenWidth)x\(screenHeight)")
print("   Haunting your cursor every 15-45 seconds...\n")

while true {
    // Get current mouse position
    let currentPos = CGEvent(source: nil)?.location ?? CGPoint(x: 500, y: 500)
    
    // Small random offset (-80 to +80 pixels) to look natural
    let dx = Int.random(in: -80...80)
    let dy = Int.random(in: -80...80)
    
    // Clamp to screen bounds
    let newX = min(max(Int(currentPos.x) + dx, 10), screenWidth - 10)
    let newY = min(max(Int(currentPos.y) + dy, 10), screenHeight - 10)
    
    let point = CGPoint(x: newX, y: newY)
    // Move the mouse
    let moveEvent = CGEvent(mouseEventSource: nil, mouseType: .mouseMoved, mouseCursorPosition: point, mouseButton: .left)
    moveEvent?.post(tap: .cghidEventTap)
    
    let now = DateFormatter.localizedString(from: Date(), dateStyle: .none, timeStyle: .medium)
    print("   👻 [\(now)] Haunted to (\(newX), \(newY))")
    
    // Wait 15-45 seconds (random to appear natural)
    let delay = UInt32.random(in: 15...45)
    sleep(delay)
}
