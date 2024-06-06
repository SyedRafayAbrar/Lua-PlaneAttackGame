push = require 'push'

Class = require 'class'

require 'Plane'
require 'Bullets'
require 'EnemyPlane'

require 'util'
require 'Boss'

-- all code related to game state and state machines
require 'StateMachine'
require 'states/BaseState'
require 'states/PlayState'
require 'states/ScoreState'
require 'states/TitleScreenState'
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

function love.load()

  sounds = {
        -- ['jump'] = love.audio.newSource('jump.wav', 'static'),
        ['explosion'] = love.audio.newSource('explosion.wav', 'static'),
        ['hurt'] = love.audio.newSource('hurt.wav', 'static'),
        ['score'] = love.audio.newSource('score.wav', 'static'),

        -- https://freesound.org/people/xsgianni/sounds/388079/
        ['music'] = love.audio.newSource('music.mp3', 'static')
    }
      -- kick off music
    sounds['music']:setLooping(true)
    sounds['music']:play()

  
  love.graphics.setDefaultFilter('nearest', 'nearest')
  
  love.window.setTitle('Dog Fight')
  
  gTextures = {
    
        ['background'] = love.graphics.newImage('graphics/background.png'),
        ['particle'] = love.graphics.newImage('graphics/particle.png')
  }
  
    
        push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        vsync = true,
        fullscreen = false,
        resizable = false
    })

         gStateMachine = StateMachine {
        ['title'] = function() return TitleScreenState() end,
        ['play'] = function() return PlayState() end,
        ['score'] = function() return ScoreState() end
    }
    gStateMachine:change('title')
          -- initialize input table
    love.keyboard.keysPressed = {}
  
end  


function love.keypressed(key)
    love.keyboard.keysPressed[key] = true

    if key == 'escape' then
        love.event.quit()
    end 
    
end

function love.keyboard.wasPressed(key)
    if love.keyboard.keysPressed[key] then
        return true
    else
        return false
    end
end



function love.update(dt)
  
  backgroundScroll = (backgroundScroll - BACKGROUND_SCROLL_SPEED * dt) 
        % BACKGROUND_LOOPING_POINT
        
     
      -- now, we just update the state machine, which defers to the right state
    gStateMachine:update(dt)

    -- reset input table
    love.keyboard.keysPressed = {}
end


function love.draw()
  push:apply('start')
  
--  local backgroundWidth = gTextures['background']:getWidth()
--  local backgroundHeight = gTextures['background']:getHeight()
   gStateMachine:render()
      -- love.graphics.draw(gTextures['background'], 0,-backgroundScroll)
   
  
  push:apply('end')
  
end  