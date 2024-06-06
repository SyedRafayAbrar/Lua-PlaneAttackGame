--[[
    PlayState Class
    Author: Colton Ogden
    cogden@cs50.harvard.edu

    The PlayState class is the bulk of the game, where the player actually controls the bird and
    avoids pipes. When the player collides with a pipe, we should go to the GameOver state, where
    we then go back to the main menu.
]]

PlayState = Class{__includes = BaseState}
local bullets = {}
local enemyPlanes = {}
local boss = {}
local plane = Plane()

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

local enemy_spawnTimer = 0
local spawnTimer = 0
local bossSpawnTimer = 0
-- size we're trying to emulate with push
VIRTUAL_WIDTH = 512
VIRTUAL_HEIGHT = 288

local backgroundScroll = 0

local BACKGROUND_SCROLL_SPEED = 15

local BACKGROUND_LOOPING_POINT = 400


function PlayState:init()
   love.graphics.setDefaultFilter('nearest', 'nearest')
  self.score = 0
  love.window.setTitle('Dog Fight')
  plane.isCollided = false
  gTextures = {
    
        ['background'] = love.graphics.newImage('graphics/background.png'),
        ['particle'] = love.graphics.newImage('graphics/particle.png')
  }
  
    
        push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        vsync = true,
        fullscreen = false,
        resizable = false
    })
end

function PlayState:update(dt)
     
  backgroundScroll = (backgroundScroll - BACKGROUND_SCROLL_SPEED * dt) 
        % BACKGROUND_LOOPING_POINT
        
      plane:update(dt)

    spawnTimer = spawnTimer + dt

    enemy_spawnTimer = enemy_spawnTimer + dt
    bossSpawnTimer = bossSpawnTimer + dt

       if spawnTimer > 0.2 and love.keyboard.isDown('space') then
        table.insert(bullets, Bullets(plane.x,plane.y))
  
        spawnTimer = 0
    end


       if enemy_spawnTimer > 2 then
        table.insert(enemyPlanes, EnemyPlane())
        enemy_spawnTimer = 0
      end
        
      if bossSpawnTimer > 20 then
        table.insert(boss, Boss())
        bossSpawnTimer = 0
      end
     

     for k, bullet in pairs(bullets) do
        bullet:update(dt)
        if bullet.isCollided then
            table.remove(bullets, k)
            return
        end
        if bullet.y < -bullet.height then
            table.remove(bullets, k)
            return
        end
 end


    for k, enemy in pairs(enemyPlanes) do
        enemy:update(dt)
        if enemy.isCollided then
          table.remove(enemyPlanes, k)
            return
        end
        if enemy.y > VIRTUAL_HEIGHT+enemy.height then
            table.remove(enemyPlanes, k)
            return
        end
end

for k, bos in pairs(boss) do
        bos:update(dt)
        
        if bos.y > VIRTUAL_HEIGHT+bos.height then
            table.remove(boss, k)
        end
  end

end

function PlayState:render()
    push:apply('start')
  
--  local backgroundWidth = gTextures['background']:getWidth()

      love.graphics.draw(gTextures['background'], 0,-backgroundScroll)
      
      if plane.isCollided then
        sounds['music']:stop()
        gStateMachine:change('score', {
                    score = self.score
                })
    else
      plane:render()
      end
      

 for k, eplane in pairs(enemyPlanes) do
  if eplane:collidesPlane(plane) then
    plane.isCollided = true
    eplane.isCollided = true 
  end
 for k, bullet in pairs(bullets) do
       if eplane:collides(bullet) then
        bullet.isCollided = true
        if eplane.bulletsCapacity == 0 then
          self.score = self.score + 10
          eplane.isCollided = true 
        end
              
    end 



    for k, bullet in pairs(bullets) do
        if not bullet.isCollided then
bullet:render()  
        end
       
    end  
end
end

 for k, boss in pairs(boss) do
 for k, bullet in pairs(bullets) do
       if boss:collides(bullet) then
             if boss.bulletsCapacity == 0 then
          boss.isCollided = true 
        end
              
    end 
 
end
 end
 
 for k, plane in pairs(enemyPlanes) do
  if plane.isCollided then
    
  else
       plane:render()
      
  end
 end
 
  for k, plane in pairs(boss) do
  if plane.isCollided then
    
  else
       plane:render()
      
  end
 end
    
    love.graphics.print("Score" .. tostring(self.score), 0, 5)
  
  push:apply('end')
  
end

  -- gStateMachine:change('score', {
  --                   score = self.score
  --               })