# 📘 Anchor UI Library - Documentation

Anchor is a lightweight, animated UI library for Roblox built to be modular, clean, and easy to use.

---

## ⚙️ Getting Started

### 1. Load the Library

You can load the library by pasting the source code directly or using `loadstring` with a hosted URL:

```lua
local Anchor = loadstring(game:HttpGet("https://yourserver.com/Anchor.lua"))()
```
### 2. Create A Window
```lua
local ui = Anchor:CreateWindow("My GUI")
```
### 3. Set A Custom Theme (Optional)
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
