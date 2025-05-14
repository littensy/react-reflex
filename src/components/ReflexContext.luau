local React = require(script.Parent.Parent.React)
local Reflex = require(script.Parent.Parent.Reflex)

local ReflexContext = React.createContext((nil :: any) :: Reflex.Producer<any, any>)

return ReflexContext
