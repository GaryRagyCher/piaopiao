
local MainScene = class("MainScene", function()
    return display.newScene("MainScene")
end)
require("app.LevelJson")
function MainScene:ctor()
    ui.newTTFLabel({text = "Hello, World", size = 64, align = ui.TEXT_ALIGN_CENTER})
        :pos(display.cx, display.cy)
        :addTo(self)
       local bgSp = display.newSprite("mineBG4.png")
       bgSp:setPosition(ccp(display.cx,display.cy))
       self:addChild(bgSp)

end

function MainScene:onEnter()
end

function MainScene:onExit()
end

return MainScene
