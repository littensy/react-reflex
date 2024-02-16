local React = require(script.Parent.Parent.React)
local ReflexContext = require(script.Parent.Parent.components.ReflexContext)

--[=[
	A hook that returns the producer passed to the `<ReflexProvider>`.

	#### Example

	```lua
	local useRootProducer = useProducer :: UseProducerHook<RootProducer>
	```

	@return The root producer
]=]
export type UseProducerHook<RootProducer> = () -> RootProducer

--[=[
	Returns the producer passed to the `<ReflexProvider>`.

	#### Example

	```lua
	local producer = useRootProducer()
	producer.increment()
	```

	@return The root producer
]=]
local function useProducer<T>(): T
	local producer = React.useContext(ReflexContext)
	assert(producer, "useProducer must be used within a <ReflexProvider> component")
	return producer
end

return useProducer
