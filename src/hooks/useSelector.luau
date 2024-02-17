local React = require(script.Parent.Parent.React)
local useProducer = require(script.Parent.useProducer)

--[=[
	A hook that returns the result of a selector function applied to the current
	state. This type is typically unnecessary if your selector function is defined
	with an explicit `state` parameter type.

	#### Example

	```lua
	local useRootSelector = useSelector :: UseSelectorHook<RootState>
	```

	@param selector A function that takes the current state and returns a value
	@param equalityFn An optional function that determines if the component should re-render
	@return The result of the selector function
]=]
export type UseSelectorHook<State> = <Result>(
	selector: (state: State) -> Result,
	equalityFn: ((next: Result, prev: Result) -> boolean)?
) -> Result

--[=[
	Returns the result of a selector function applied to the current state.

	#### Example

	```lua
	local counter = useSelector(function(state: RootState)
		return state.counter
	end)
	```

	@param selector A function that takes the current state and returns a value
	@param equalityFn An optional function that determines if the component should re-render
	@return The result of the selector function
]=]
local function useSelector<T>(selector: (state: any) -> T, equalityFn: ((next: T, prev: T) -> boolean)?): T
	local producer = useProducer()
	local latestSelector = React.useRef(selector) :: { current: typeof(selector) }
	local didMount = React.useRef(true)

	local result, setResult = React.useState(function()
		return selector(producer:getState())
	end)

	React.useEffect(function()
		if didMount.current then
			didMount.current = false
		else
			setResult(selector(producer:getState()))
			latestSelector.current = selector
		end
	end, { selector })

	React.useEffect(function()
		local prevResult = result

		return producer:subscribe(function(nextState)
			local nextResult = latestSelector.current(nextState)
			local shouldUpdate = if equalityFn then not equalityFn(nextResult, prevResult) else nextResult ~= prevResult

			if shouldUpdate then
				prevResult = nextResult
				setResult(nextResult)
			end
		end)
	end, { producer })

	return result
end

return useSelector
