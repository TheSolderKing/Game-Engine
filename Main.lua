-- GameEngine

-- Use this function to perform your initial setup
function setup()
    print("Hello World!")
    readImage("Project:People")
    ss = SpriteSheet(WIDTH/2,HEIGHT/2,WIDTH/10,HEIGHT/10,readImage("Project:People"),25,25,1)
    ss:fps(3)
    ss:newSequence("default", 1,3,1,2)
    ss:newSequence("random",10,11,12,13,14)
    
    --[[
    USAGE:
    
    SpriteSheet(
    X, <-The x coordinate the mesh will be centered upon|
    Y, <-The y coordinate the mesh will be centered upon|
    WIDTH,   <- The width of the newly created rectangle|
    HEIGHT,  <-The height of the newly created rectangle|
    IMG,  <-The image name or image variable of the mesh|
    ROWS, <- The number of rows that the spritesheet has|
    COLUMNS, <-The columns that the spritesheet contains|
    SEQUENCE,  <-The sequence the sprites should play in|
    INIT <-The initial starting point in the above table|
    )
    
    NOTE:
    
    The sprites are numbered as follows:
    
    1 2 3 4 5
    6 7 8 9 10
    
    Of course, the number of rows/columns will vary from time to time. 
    
    But basically, the top left is 1 and the numbers continue to the right, then jump to the left
    in the next row down and continue counting
    ]]--
    
    c = CircleJoystick(WIDTH/10,HEIGHT/10)
    tm = TileMap(readImage("Project:People"),{
    {1,2},
    {3,50}
    },{},25,25,WIDTH/2,HEIGHT/2)
end

-- This function gets called once every frame
function draw()
    -- This sets a dark background color 
    background(0, 0, 255, 255)

    -- This sets the line thickness
    strokeWidth(5)

    -- Do your drawing here
    noSmooth()
    tm:draw()
    ss:draw()
    c:draw()
    ss.x = ss.x + c.dx * 5
    ss.y = ss.y + c.dy * 5
    if c.tId and ss.playing == false then
        ss:play("default")
    elseif not c.tId and ss.playing == true then
        ss:stopAt(1)
    end
end

function touched(t)
    c:touched(t)
end

