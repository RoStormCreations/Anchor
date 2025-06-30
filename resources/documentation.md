# 📘 Anchor UI Library - Documentation

Anchor is a lightweight, animated UI library for Roblox built to be modular, clean, and easy to use.

---

## ⚙️ Getting Started

### 1. Load the Library

You can load the library by pasting the source code directly or using `loadstring` with a hosted URL:

```lua
local Anchor = loadstring(game:HttpGet("https://yourserver.com/Anchor.lua"))()
```

> Replace the URL with your actual hosting location (e.g., GitHub, Pastebin, etc.)

---

### 2. Create a UI Window

```lua
local ui = Anchor:CreateWindow("My UI Title")
```

This creates a centered, draggable UI window with a tab system.

---

### 3. Set a Custom Theme (Optional)

```lua
ui:SetTheme({
    Main = Color3.fromRGB(10, 10, 10),
    Second = Color3.fromRGB(30, 30, 30),
    Accent = Color3.fromRGB(255, 100, 100),
    Stroke = Color3.fromRGB(80, 80, 80),
    Text = Color3.fromRGB(255, 255, 255),
    TextDark = Color3.fromRGB(150, 150, 150)
})
```

You can call `SetTheme()` after `CreateWindow()` to apply your own color palette.

---

## 🧩 Tabs & Elements

### Add a Tab

```lua
local mainTab = ui:AddTab("Main")
```

Each tab holds its own set of UI elements.

---

### Add a Label

```lua
mainTab:AddLabel("Welcome to Anchor UI")
```

Displays static text.

---

### Add a Button

```lua
mainTab:AddButton("Click Me", function()
    print("Button was clicked!")
end)
```

Executes the function when clicked.

---

### Add a Toggle

```lua
mainTab:AddToggle("Enable Feature", function(state)
    print("Toggle is now:", state)
end)
```

Creates a toggle switch. When clicked:
- ✔ means ON
- ✖ means OFF

The current state (`true` or `false`) is passed to the callback.

---

## 🛠️ API Reference

| Method                   | Description                                 |
|--------------------------|---------------------------------------------|
| `Anchor:CreateWindow(title)` | Creates a new UI window                |
| `ui:SetTheme(themeTable)`    | Applies a custom theme to the UI       |
| `ui:AddTab(name)`            | Adds a new tab to the UI               |
| `tab:AddLabel(text)`         | Adds a label to the tab                |
| `tab:AddButton(text, cb)`    | Adds a clickable button                |
| `tab:AddToggle(text, cb)`    | Adds a toggle with callback            |

---

## 🎨 Theme Format

Here's an example theme table structure:

```lua
{
    Main = Color3.fromRGB(25, 25, 25),
    Second = Color3.fromRGB(32, 32, 32),
    Accent = Color3.fromRGB(85, 170, 255),
    Stroke = Color3.fromRGB(60, 60, 60),
    Text = Color3.fromRGB(240, 240, 240),
    TextDark = Color3.fromRGB(140, 140, 140)
}
```

Apply it using `ui:SetTheme(yourThemeTable)`.

---

## 📦 Final Notes

- You can paste the full source directly or load it from the web
- All UI runs locally and is editable via the script
- Works in any modern Roblox executor that supports `getfenv`, `game:HttpGet`, and GUI operations

---

## 🔒 Credits

- UI Library by Valoric
