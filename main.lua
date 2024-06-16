_G.love = require("love")

-- Load some default values for our rectangle.

function love.load()
    jack = {
        x = 0,
        y = 0,
        sprite = love.graphics.newImage("sprites/spritesheet.png"),
        animation = {
            direction = "right",
            idle = true,  -- 閒置不動
            frame = 1,
            max_frames = 8,
            speed = 50,
            timer = 0.1,
        }
    }

    -- 5352 x 569
    SPRITE_WIDTH, SPRITE_HEIGHT = 5352, 569
    QUAD_WIDTH = 669
    QUAD_HEIGHT = SPRITE_HEIGHT

    
    
    quads = {}

    for i = 1, jack.animation.max_frames do
        quads[i] = love.graphics.newQuad(QUAD_WIDTH * (i -1), 0, QUAD_WIDTH, QUAD_HEIGHT, SPRITE_WIDTH, SPRITE_HEIGHT)
        
    end



end

-- Increase the size of the rectangle every frame.
function love.update(dt)
    if love.keyboard.isDown("d") then
        jack.animation.idle = false
        jack.animation.direction = "right"
    elseif love.keyboard.isDown("a") then
        jack.animation.idle = false
        jack.animation.direction = "left"
    else 
        jack.animation.idle = true
        jack.animation.frame = 1
    end



    if not jack.animation.idle then
        jack.animation.timer = jack.animation.timer + dt

        if jack.animation.timer > 0.2 then
            jack.animation.timer = 0.1

            jack.animation.frame = jack.animation.frame + 1

            if jack.animation.direction == "right" then
                jack.x = jack.x + jack.animation.speed
            elseif jack.animation.direction == "left" then
                jack.x = jack.x - jack.animation.speed
            end

            if jack.animation.frame > jack.animation.max_frames then
                jack.animation.frame = 1
            end


        end
    end
end

-- Draw a coloured rectangle.
function love.draw()
    love.graphics.scale(0.3)

    if jack.animation.direction == "right" then
        love.graphics.draw(jack.sprite, quads[jack.animation.frame], jack.x, jack.y)
    elseif jack.animation.direction == "left" then
        love.graphics.draw(jack.sprite, quads[jack.animation.frame], jack.x, jack.y, 0, -1, 1, QUAD_WIDTH, 0)
    end 
    
end