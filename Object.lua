Object = class()

function Object:init(x,z,facing,model)
    -- you can accept and set parameters here
    self.x,self.z = x,z
    self.facing = facing
    
    self.id = model
    local objText = readText("Project:" .. model)
    self.verts = {}
    self.tex = {}
    self:decodeText(objText)
end

function Object:decodeText(file)
    local pointsDict = {}
    local texDict = {}
    for x,y,z in string.gmatch(file,"v ([0-9.-]+) ([0-9.-]+) ([0-9.-]+)") do
        --TODO: insert code to handle facing different directions here
        local rx,rz
        if self.facing == 1 then
            rx = x
            rz = z
        elseif self.facing == 2 then
            rx = z
            rz = x
        elseif self.facing == 3 then
            rx = -x
            rz = -z
        elseif self.facing == 4 then
            rx = -z
            rz = -x
        end
        --table.insert(pointsDict,vec3(rx+self.x*16,y,rz+self.z*16))
        vec = vec3(rx,y,rz) + vec3(self.x*16,0,self.z*16)
        table.insert(pointsDict,vec)
    end
    for x,y in string.gmatch(file,"vt ([0-9.-]+) ([0-9.-]+)") do
        table.insert(texDict,vec2(x,0))
    end

    for p1,t1,p2,t2,p3,t3 in string.gmatch(file, "f ([0-9]+)/([0-9]+)/[0-9]+ ([0-9]+)/([0-9]+)/[0-9]+ ([0-9]+)/([0-9]+)/[0-9]+") do
        if self.facing == 1 or self.facing == 3 then
            table.insert(self.verts,pointsDict[p1 + 0])
            table.insert(self.verts,pointsDict[p2 + 0])
            table.insert(self.verts,pointsDict[p3 + 0])
        elseif self.facing == 2 or self.facing ==4 then
            table.insert(self.verts,pointsDict[p3 + 0])
            table.insert(self.verts,pointsDict[p2 + 0])
            table.insert(self.verts,pointsDict[p1 + 0])
        end
        
        table.insert(self.tex, texDict[t1 + 0])
        table.insert(self.tex, texDict[t2 + 0]) 
        table.insert(self.tex, texDict[t3 + 0])
    end
end

function Object:addToTables(verts,tex)
    for i,v in pairs(self.verts) do
        table.insert(verts,v)
        table.insert(tex,self.tex[i])
    end
end
