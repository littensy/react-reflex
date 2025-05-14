--!nocheck

if script.Parent.Parent:FindFirstChild("reflex") then
	return require(script.Parent.Parent.reflex.src)
end

local Reflex = require(script.Parent.Parent.Reflex)

export type Producer<State, Actions> = Reflex.Producer<State, Actions>

return Reflex
