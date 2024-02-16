curl -o scripts/roblox.d.lua https://raw.githubusercontent.com/JohnnyMorganz/luau-lsp/main/scripts/globalTypes.d.lua

rojo sourcemap dev.project.json -o sourcemap.json

luau-lsp analyze --defs=scripts/roblox.d.lua --sourcemap=sourcemap.json --ignore="**/_Index/**" src
selene src
stylua --check src
eslint src

rm scripts/roblox.d.lua
