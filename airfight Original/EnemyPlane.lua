
EnemyPlane = Class{}



WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 512
VIRTUAL_HEIGHT = 288


function EnemyPlane:init()
    -- load bird image from disk and assign its width and height
    self.image = love.graphics.newImage('graphics/enemy.png')
    self.width = self.image:getWidth()
    self.height = self.image:getHeight()
     
    -- position enemy in the middle of the screen
    self.x = math.random(0, VIRTUAL_WIDTH-20)
    self.y = -20

     self.bulletsCapacity = 2
    self.isCollided = false

    self.enemyType = 0
    self.dy = 50

end
function EnemyPlane:collides(Bullets)
  
    if (self.x + 2) + (self.width - 4) >= Bullets.x and self.x + 2 <= Bullets.x + BULLETS_WIDTH then
        if (self.y + 2) + (self.height - 4) >= Bullets.y and self.y + 2 <= Bullets.y + BULLETS_HEIGHT then
            if self.bulletsCapacity > 0 then
              sounds['explosion']:play() 
            self.bulletsCapacity = self.bulletsCapacity - 1
        end
            return true
        end
    end

    return false
end

function EnemyPlane:collidesPlane(Plane)
  
    if (self.x + 2) + (self.width - 4) >= Plane.x and self.x + 2 <= Plane.x + 50 then
        if (self.y + 2) + (self.height - 4) >= Plane.y and self.y + 2 <= Plane.y + 50 then
            return true
        end
    end

    return false
end


function EnemyPlane:update(dt)
  self.y = self.y + (self.dy*dt)
end

function EnemyPlane:render()
    love.graphics.draw(self.image, self.x, self.y)
end

