TurtleDrawing = class()

function TurtleDrawing:init(x,y)
    -- you can accept and set parameters here
    self.pos = vec2(x,y)
    self.stack = {}
    self.rot = 0
    self.lines = {}
end

function TurtleDrawing:draw()
    -- Codea does not automatically call this method
    stroke(0)
    for i,v in pairs(self.lines) do
        strokeWidth(100)
        line(v.p1.x,v.p1.y,v.p2.x,v.p2.y)
    end
end

function TurtleDrawing:move(vec)
    local opos = self.pos
    local newpos = self.pos + vec
    self.pos = self.pos + vec
    self:addLine(opos,newpos)
end

function TurtleDrawing:moveForward(amount)
    local opos = self.pos
    local newpos = self.pos + vec2(amount,0):rotate(math.rad(self.rot)) 
    self.pos = self.pos + vec2(amount,0):rotate(math.rad(self.rot))
    self:addLine(opos,newpos)
end

function TurtleDrawing:rotate(amount)
    self.rot = self.rot + amount 
end

function TurtleDrawing:push()
    table.insert(self.stack, {pos = vec2(self.pos.x,self.pos.y),rot = self.rot})
end

function TurtleDrawing:pop()
    self.pos = self.stack[#self.stack].pos
    self.rot = self.stack[#self.stack].rot
    table.remove(self.stack,#self.stack)
end

function TurtleDrawing:addLine(pos1,pos2)
    self.lines[#self.lines+1] = {p1 = pos1,p2 = pos2}
end
