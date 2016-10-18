Mask = class()

function Mask:init(data, width, height, mirrorX,mirrorY)
    -- you can accept and set parameters here
    self.data = data
    self.width = width
    self.height = height
    self.mirrorX = mirrorX
    self.mirrorY = mirrorY 
end

