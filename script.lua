local player = game:GetService("Players").LocalPlayer

-- Реалистичный текст "бана" на английском
local banMessage = "You have been permanently banned from this experience.\n\nReason: Cheating/Exploiting detected.\nError Code: 267"

player:Kick(banMessage)
