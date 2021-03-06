TileMap = class()

function TileMap:init(img, map, values, rows, columns, width, height)
    -- you can accept and set parameters here
    self.img = img
    self.map = map
    self.values = values
    self.width, self.height = width, height
    self.rows, self.columns = rows, columns
    
    self.translation = {x = 0, y = 0}
    
    self.mesh = mesh()
    self.mesh.texture = self.img
    for y,a in pairs(self.map) do
        for x,b in pairs(a) do
            local i = self.mesh:addRect((x-1)*self.width + self.width/2,(#self.map - y)*self.height + self.height/2,self.width,self.height)
            local id = self.values[b] or b
            self.mesh:setRectTex(i, ((id-1) % rows)/rows, (columns - math.ceil(id/rows))/columns,1/rows,1/columns)
        end
    end
end

function TileMap:draw()
    -- Codea does not automatically call this method
    pushMatrix()
    translate(self.translation.x,self.translation.y)
    self.mesh:draw()
    popMatrix()
end

function TileMap:translate(x,y)
    self.translation = {x = x, y = y}
end

function TileMap:getAt(x,y)
    local x = x - self.translation.x
    local y = y - self.translation.y
    
    
end
