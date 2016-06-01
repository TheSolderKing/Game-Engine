Buffer = class()

function Buffer:init(...)
    -- you can accept and set parameters
    local args = {...}
    self.data = {}
    self.initial = {}
    assert(#args%2==0,"Number of parameters must be even")
    for i=1,#args-1,2 do
        self.initial[args[i]] = args[i+1]
        self.data[args[i]] = args[i+1]
    end
end

function Buffer:add(key,value)
    -- Codea does not automatically call this method
    self.data[key] = self.data[key] + value
end

function Buffer:clear()
    self.data = {}
    for key,value in pairs(self.initial) do
        self.data[key] = value
    end
end

function Buffer:getValue(key)
    return self.data[key]
end
