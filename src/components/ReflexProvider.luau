local React = require(script.Parent.Parent.React)
local Reflex = require(script.Parent.Parent.Reflex)
local ReflexContext = require(script.Parent.ReflexContext)

type Props = {
	--[=[
		The root producer to provide to the context
	]=]
	producer: Reflex.Producer<any, any>,
	--[=[
		An optional initial state snapshot to merge into the producer's state
	]=]
	initialState: { [any]: any }?,
	children: any,
}

local function ReflexProvider(props: Props)
	React.useMemo(function()
		-- Run in useMemo to set the state before rendering children
		if props.initialState then
			local state = table.clone(props.producer:getState())

			for key, value in props.initialState do
				state[key] = value
			end

			props.producer:setState(state)
		end
	end, {})

	return React.createElement(ReflexContext.Provider, { value = props.producer }, props.children)
end

return ReflexProvider
