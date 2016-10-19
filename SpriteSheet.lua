SpriteSheet = class()

function SpriteSheet:init(x,y,w,h,img, rows, clms, start)
    --save dimensions/position
    self.x,self.y,self.w,self.h = x,y,w,h
    --save the image we will be using
    self.img = img
    --save the width and height of the image grid for future use
    self.iw,self.ih = rows,clms
    --whether or not to automatically advance in time
    self.playing = false
    self.timeInterval = 0
    self.curTime = 0
    self.continuous = false
    self.numPlayed = 0
    self.numToPlay = 0
    self.sequences = {}
    self.sequence = {}
    self.frame = 1
    
    --do all the nitty-gritty setup stuff with the mesh
    self.mesh = mesh()
    self.mesh.texture = self.img
    self.index = self.mesh:addRect(0,0,self.w,self.h)
    --self.mesh:setRectTex(self.index,((self.sequence[self.frame]-1)%self.iw)/self.iw,(self.ih-math.ceil(self.sequence[self.frame]/self.iw))/self.ih,1/self.iw,1/self.ih)
    self:setFrame(start)
end

function SpriteSheet:draw()
    -- Codea does not automatically call this method
    noSmooth()
    pushMatrix()
    translate(self.x,self.y)
    self.mesh:draw()
    popMatrix()
    
    if self.playing then
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
    if self.frame == #self.sequence then
        self.numPlayed = self.numPlayed + 1
    end
    self.frame = (self.frame)%(#self.sequence)+1
    self:setFrameInAnim(self.frame)
    if self.numPlayed >= self.numToPlay and not self.continuous then
        self:stop()
    end
    
    if self.sequence[self.frame] == self.stopValue then
        self:stop()
    end
end

function SpriteSheet:setFrame(f)
    self.mesh:setRectTex(self.index,((f-1)%self.iw)/self.iw,(self.ih-math.ceil(f/self.iw))/self.ih,1/self.iw,1/self.ih)
end

function SpriteSheet:setFrameInAnim(f)
    self.frame = f
    self.mesh:setRectTex(self.index,((self.sequence[self.frame]-1)%self.iw)/self.iw,(self.ih-math.ceil(self.sequence[self.frame]/self.iw))/self.ih,1/self.iw,1/self.ih)
end

function SpriteSheet:setIndex(i)
    self.mesh:setRectTex(self.index,((i-1)%self.iw)/self.iw,(self.ih-math.ceil(i/self.iw))/self.ih,1/self.iw,1/self.ih)
end

function SpriteSheet:newSequence(name, ...)
    self.sequences[name] = {...}
end

function SpriteSheet:fps(fps)
    self.timeInterval = 60/fps
end

function SpriteSheet:play(name, amount)
    self.sequence = self.sequences[name]
    self.numPlayed = 0
    if not amount then self.continuous = true else self.continuous = false self.numToPlay = amount end
    self.playing = true
end

function SpriteSheet:stop()
    self.numPlayed = 0
    self.numToPlay = 0
    self.continuous = false
    self.playing = false
    self.stopValue = nil
end

function SpriteSheet:stopAt(value)
    self.stopValue = value
end
