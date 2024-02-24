local React = require(script.Parent.Parent.React)
local useSelector = require(script.Parent.useSelector)

local function pack(...)
	return { ... }
end

--[=[
	Similar to `useSelector`, but accepts a selector factory that returns a
	selector. The selector factory is only called when the arguments change, and
	the selector is memoized.
	
	#### Example

	```lua
	local useRootSelectorCreator = useSelectorCreator :: UseSelectorCreatorHook<RootState>
	```

	@param selectorFactory A function that returns a selector
	@param ... Arguments to pass to the selector factory
	@return The result of the selector
]=]
export type UseSelectorCreatorHook<State> = <Result, Args...>(
	selectorFactory: (Args...) -> (state: State) -> Result,
	Args...
) -> Result

--[=[
	Similar to `useSelector`, but accepts a selector factory that returns a
	selector. The selector factory is only called when the arguments change, and
	the selector is memoized.

	#### Example

	```lua
	local function selectUserById(id: string)
		return function(state: RootState)
			return state.users[id]
		end
	end

	local user = useSelectorCreator(selectUserById, "123")
	```

	@param selectorFactory A function that returns a selector
	@param ... Arguments to pass to the selector factory
	@return The result of the selector
]=]
local function useSelectorCreator<Result, Args...>(selectorFactory: (Args...) -> (state: any) -> Result, ...: Args...)
	local arguments = pack(...)

	local selector = React.useMemo(function()
		return selectorFactory(table.unpack(arguments))
	end, arguments)

	return useSelector(selector)
end

return useSelectorCreator
