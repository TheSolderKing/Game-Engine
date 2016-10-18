SpriteSheet = class()

function SpriteSheet:init(x,y,w,h,img, rows, clms, sequence, init)
    --save dimensions/position
    self.x,self.y,self.w,self.h = x,y,w,h
    --save the image we will be using
    self.img = img
    --save the width and height of the image grid for future use
    self.iw,self.ih = rows,clms
    --save the sequence the user gives us
    self.sequence = sequence
    --save the starting frame
    self.frame = init
    --whether or not to automatically advance in time
    self.timing = false
    self.timeInterval = 0
    self.curTime = 0
    
    
    --do all the nitty-gritty setup stuff with the mesh
    self.mesh = mesh()
    self.mesh.texture = self.img
    self.index = self.mesh:addRect(0,0,self.w,self.h)
    self.mesh:setRectTex(self.index,((self.sequence[self.frame]-1)%self.iw)/self.iw,(self.ih-math.ceil(self.sequence[self.frame]/self.iw))/self.ih,1/self.iw,1/self.ih)
end

function SpriteSheet:draw()
    -- Codea does not automatically call this method
    noSmooth()
    pushMatrix()
    translate(self.x,self.y)
    self.mesh:draw()
    popMatrix()
    
    if self.timing then
        self:updateTimer()
    end
end

function SpriteSheet:updateTimer()
    self.curTime = self.curTime + 1
    if self.curTime%self.timeInterval == 0  then
        self.curTime = 0
        self:advanceFrame()
    end
end

function SpriteSheet:advanceFrame()
    self.frame = (self.frame)%(#self.sequence)+1
    self.mesh:setRectTex(self.index,((self.sequence[self.frame]-1)%self.iw)/self.iw,(self.ih-math.ceil(self.sequence[self.frame]/self.iw))/self.ih,1/self.iw,1/self.ih)
end

function SpriteSheet:setFrame(f)
    self.frame = f
    self.mesh:setRectTex(self.index,((self.sequence[self.frame]-1)%self.iw)/self.iw,(self.ih-math.ceil(self.sequence[self.frame]/self.iw))/self.ih,1/self.iw,1/self.ih)
end

function SpriteSheet:setIndex(i)
    self.mesh:setRectTex(self.index,((i-1)%self.iw)/self.iw,(self.ih-math.ceil(i/self.iw))/self.ih,1/self.iw,1/self.ih)
end

function SpriteSheet:newSequence(...)
    self.sequence = {...}
end

function SpriteSheet:tStart(interval)
    self.timeInterval = interval
    self.timing = true
end

function SpriteSheet:tStop()
    self.timing = false
end
