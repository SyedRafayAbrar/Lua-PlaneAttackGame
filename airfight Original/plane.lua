
Plane = Class{}

PLANE_SPEED = 200

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720



VIRTUAL_WIDTH = 512
VIRTUAL_HEIGHT = 288

function Plane:init()
    -- load bird image from disk and assign its width and height
    self.image = love.graphics.newImage('graphics/plane.png')
    self.width = self.image:getWidth()
    self.height = self.image:getHeight()
     
    -- position bird in the middle of the screen
    self.x = VIRTUAL_WIDTH /2  - (self.width /2)
    self.y = VIRTUAL_HEIGHT - (self.height+5)
    self.isCollided = false

end


function Plane:update(dt)
    -- apply gravity to velocity
    if love.keyboard.isDown('left') then
        self.dx = -PLANE_SPEED
    elseif love.keyboard.isDown('right') then
        self.dx = PLANE_SPEED
    else
        self.dx = 0
    end

    -- math.max here ensures that we're the greater of 0 or the player's
    -- current calculated Y position when pressing up so that we don't
    -- go into the negatives; the movement calculation is simply our
    -- previously-defined paddle speed scaled by dt
    if self.dx < 0 then
        self.x = math.max(0, self.x + self.dx * dt)
    -- similar to before, this time we use math.min to ensure we don't
    -- go any farther than the bottom of the screen minus the paddle's
    -- height (or else it will go partially below, since position is
    -- based on its top left corner)
    else
        self.x = math.min(VIRTUAL_WIDTH - self.width, self.x + self.dx * dt)
    end
    
    
end

function Plane:render()
    love.graphics.draw(self.image, self.x, self.y)
   
end