local package = script.Parent.Parent:FindFirstChild("Reflex") or script.Parent.Parent:FindFirstChild("reflex").src

assert(package, `Could not find Reflex in {script.Parent.Parent:GetFullName()}`)

type Reflex = typeof(require(script.Parent.Parent.Reflex))

export type Producer<State, Actions> = typeof((function()
	local Reflex = require(script.Parent.Parent.Reflex)
	return {} :: Reflex.Producer<State, Actions>
end)())

return require(package) :: Reflex
