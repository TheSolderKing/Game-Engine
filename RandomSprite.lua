RandomSprite = class()

function RandomSprite:init(mask, options)
    -- you can accept and set parameters here
    if mask.mirrorX then
        self.width = mask.width * 2
    else
        self.width = mask.width
    end
    if mask.mirrorY then
        self.height = mask.height * 2
    else
        self.height = mask.height
    end
    self.mask = mask
    self.data = {}
    self.options = options
    if options.colored then
        self.color = color(math.random()*255,math.random()*255,math.random()*255)
    end
    
    self.image = image(self.width,self.height)
    
    for y=1,self.height do
        for x=1,self.width do
            self:set(x,y,-1)
        end
    end
    
    self:generate()
    
    if self.mask.mirrorX then
        self:mirrorX()
    end
    
    if self.mask.mirrorY then
        self:mirrorY()
    end
    if self.options.edged then
        self:edges() 
    end
    self:renderPixels()
    
end

function RandomSprite:set(x,y,val)
    self.data[(y-1)*self.width+x] = val
end

function RandomSprite:get(x,y)
    return self.data[(y-1)*self.width+x]
end

function RandomSprite:mirrorX()
    local w = math.floor(self.width/2)
    for y=1,self.height do
        for x=1,w do
            self:set(self.width-(x-1),y,self:get(x,y))
        end
    end
end

function RandomSprite:mirrorY()
    local h = math.floor(self.height/2)
    for y=1,h do
        for x=1,self.width do
            self:set(x,self.height-(y-1),self:get(x,y))
        end
    end
end

function RandomSprite:generate()
    local h = self.mask.height
    local w = self.mask.width
    for y=1,h do
        for x=1,w do
            self:set(x,y,self.mask.data[(y-1)*w+x])
        end
    end
    for y=1,self.height do
        for x=1,self.width do
            local val = self:get(x,y)
            if val == 1 then
                val = val * math.floor(math.random() + 0.5)
            elseif val == 2 then
                if math.random() > 0.5 then
                    val = 1
                else
                    val = -1
                end
            end
            self:set(x,y,val)
        end
    end
end

function RandomSprite:edges()
    for y=1,self.height do
        for x=1,self.width do
            if self:get(x,y) > 0 then
                if y-1 > 0 and self:get(x,y-1) == 0 then
                    self:set(x,y-1,-1)
                end
                if y+1<=self.height and self:get(x,y+1) == 0 then
                    self:set(x,y+1,-1)
                end
                if x-1 > 0 and self:get(x-1,y) == 0 then
                    self:set(x-1,y,-1)
                end
                if x+1<=self.width and self:get(x+1,y) == 0 then
                    self:set(x+1,y,-1)
                end
            end
        end
    end
end

function RandomSprite:renderPixels()
    for y=1,self.height do
        for x=1,self.width do
            val = self:get(x,y)
            if self.options.colored then
                if val == -1 then
                    self.image:set(x,y,color(self.color.r*0.3,self.color.g*0.3,self.color.b*0.3))
                elseif val == 1 then
                    multi = math.random(40,100)/100
                    rmulti = math.random(80,100)/100
                    gmulti = math.random(80,100)/100
                    bmulti = math.random(80,100)/100
                    self.image:set(x,y,color(self.color.r*multi*rmulti,self.color.g*multi*gmulti,self.color.b*multi*bmulti))
                end
            else
                if val == -1 then
                    self.image:set(x,y,color(0))
                end
            end
        end
    end
end

function RandomSprite:draw(x,y)
    -- Codea does not automatically call this method
    pushMatrix()
    noSmooth()
    translate(x,y)
    scale(20,-20)
    sprite(self.image,0,0)
    popMatrix()
end

function RandomSprite:touched(touch)
    -- Codea does not automatically call this method
end
