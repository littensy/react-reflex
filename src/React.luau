local packages = if script.Parent.Parent:FindFirstChild("React")
	then script.Parent.Parent
	else script.Parent.Parent:FindFirstChild("ReactLua")

assert(packages, `Could not find React or ReactLua in {script.Parent.Parent:GetFullName()}`)

type React = typeof(require(script.Parent.Parent.React))

export type Context<T> = typeof((function()
	local React = require(script.Parent.Parent.React)
	return {} :: React.Context<T>
end)())

return require(packages.React) :: React
