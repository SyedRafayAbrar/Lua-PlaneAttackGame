Bullets = Class{}



local BULLET_SPEED = 200

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 512
VIRTUAL_HEIGHT = 288

BULLETS_WIDTH = 63
BULLETS_HEIGHT = 60



function Bullets:init(planeX,planeY)
    -- load bird image from disk and assign its width and height
    self.image = love.graphics.newImage('graphics/Bullet.png')
    self.width = self.image:getWidth()
    self.height = self.image:getHeight()
     self.isCollided = false

    
    self.x = planeX + 7
    self.y = planeY - 30

end

function Bullets:update(dt)
  
   self.y = self.y - (BULLET_SPEED*dt)
   
end

function Bullets:render()
  
    love.graphics.draw(self.image, self.x, self.y)
    
end