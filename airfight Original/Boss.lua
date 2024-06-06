
Boss = Class{}


WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 512
VIRTUAL_HEIGHT = 288


function Boss:init()
    -- load bird image from disk and assign its width and height
    self.image = love.graphics.newImage('graphics/boss.png')
    self.width = self.image:getWidth()
    self.height = self.image:getHeight()
     
    -- position enemy in the middle of the screen
    self.x = math.random(0, VIRTUAL_WIDTH-20)
    self.y = -20

    self.bulletsCapacity = 10
    self.isCollided = false

    self.enemyType = 0
    self.isRight = true
    self.dx = 0

end
function Boss:collides(Bullets)

    if (self.x + 2) + (self.width - 4) >= Bullets.x and self.x + 2 <= Bullets.x + BULLETS_WIDTH then
        if (self.y + 2) + (self.height - 4) >= Bullets.y and self.y + 2 <= Bullets.y + BULLETS_HEIGHT then
             if self.bulletsCapacity > 0 then
            self.bulletsCapacity = self.bulletsCapacity - 1
        end
            return true
        end
    end
    return false
end

function Boss:update(dt)
   self.x = self.x + self.dx * dt 
        

 if self.x+self.width > VIRTUAL_WIDTH - 10 then
    self.x = VIRTUAL_WIDTH - self.width
    self.dx = -self.dx
      end
   
        
    if self.x <= 0 then
        self.x = 0

     self.dx = dx 
    
    end
   
 
end
    


function Boss:render()
    love.graphics.draw(self.image, self.x, self.y)
    love.graphics.print("BOSS", 0,VIRTUAL_HEIGHT/2)
end

