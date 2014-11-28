--
-- Author: qiushaiqiu
-- Date: 2014-11-27 14:53:51

--资源加载页面
local LoadingScene = class("LoadingScene", function()
	return display.newScene("LoadingScene")
end)

function LoadingScene:ctor()

	--加载资源
	CCSpriteFrameCache:sharedSpriteFrameCache():addSpriteFramesWithFile(ConstData.FISH_PLIST)
	--添加背景
	local bg = display.newSprite(ConstData.LOADING_BG)
	bg:setPosition(ccp(display.cx, display.cy))
	bg:setScale(2)
	self:addChild(bg)

	---[[添加进度条
	self._progressTimer = display.newProgressTimer("loadingProgress.png", kCCProgressTimerTypeBar)
	self._progressTimer:setPosition(ccp(display.cx, display.cy))
	self._progressTimer:setMidpoint(ccp(0, 0.5))
	self._progressTimer:setBarChangeRate(ccp(1, 0))
	self:addChild(self._progressTimer)

	local sharedScheduler = CCDirector:sharedDirector():getScheduler()
	self._schedulerPro = sharedScheduler:scheduleScriptFunc(function ()
			if self._progressTimer:getPercentage() < 100 then
				local to = CCProgressTo:create(1, 100)
          		self._progressTimer:runAction(to)
          	elseif self._progressTimer:getPercentage() >= 100 then
          		local startScene = StartScene.new()
          		CCDirector:sharedDirector():replaceScene(startScene)	
		end
		end, 1, false)
          
	--添加资源加载标签
	local loadingText = ui.newTTFLabel({text = "loading ... ", size = 30})
	loadingText:setPosition(ccp(display.cx, display.cy - 30))
	self:addChild(loadingText)

	self:init()
end


function LoadingScene:init()
	
end


function LoadingScene:onEnter()
end

function LoadingScene:onExit()
	CCDirector:sharedDirector():getScheduler():unscheduleScriptEntry(self._schedulerPro)
end

return LoadingScene