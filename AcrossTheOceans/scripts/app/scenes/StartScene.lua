--
-- Author: gary
-- Date: 2014-11-27 14:59:56
--开始界面
local StartScene = class("StartScene", function ()
	return display.newScene()
end)
require("app.ConstData")
local size = CCDirector:sharedDirector():getWinSize()--设计分辨率
local bubble_point1 = ccp(100,0)--泡泡出生点中心点1的x
local bubble_point2 = ccp(display.cx-100,-100)----泡泡出生中心点2的x


--背景动画
function StartScene:bgAction()
	local move1 = CCMoveBy:create(1.2, ccp(0,-50))
	local move2 = CCMoveBy:create(1.2, ccp(50,-30))
	local move3 = CCMoveBy:create(1.2, ccp(50,30))
	local move4 = CCMoveBy:create(1.2, ccp(0,50))
	local array = CCArray:create()
	array:addObject(move1)
	array:addObject(move2)
	array:addObject(move3)
	array:addObject(move4)
	local seq = CCSequence:create(array)
	local seq1 = CCSequence:createWithTwoActions(seq, seq:reverse())
	local repeatForever = CCRepeatForever:create(seq1)
	self._bgSp:runAction(repeatForever)
end

function StartScene:ctor()
	--背景层,放置背景图片
	local bgLayer = display.newLayer()
	bgLayer:setScale(1.4)
	self._bgSp = display.newSprite(ConstData.START_BG)
	self._bgSp:setPosition(ccp(display.cx,display.cy))
	bgLayer:addChild(self._bgSp)
	self:addChild(bgLayer,0)
	self:bgAction()

     --背景音乐
     --audio.playSound(SEA_SOUNDS, true)

	--泡泡 
	local sharedScheduler =  CCDirector:sharedDirector():getScheduler()
	self._sharedScheduler = sharedScheduler:scheduleScriptFunc(function()

	 local count = math.random(2,4)--5-10个泡泡
     for i = 0,count do
     	local pointX = math.random(bubble_point1.x-40,bubble_point1.x+40)--泡泡出生点的x
     	local pointY = math.random(bubble_point2.y-40,bubble_point2.y+40)--泡泡出生点的y
     	local size = math.random()--0-1之间的数字
     	local bubbleSp = display.newSprite(ConstData.BUBBLE)
     	bubbleSp:setScale(size)
     	bubbleSp:setPosition(ccp(pointX,pointY))
     	self:addChild(bubbleSp,1)

     	local MoveToTop = CCEaseExponentialIn:create(CCMoveTo:create(10.0, ccp(pointX,display.height)))
     	local leftOrRightMove = CCMoveBy:create(0.3, ccp(10,0))
     	local LeftRightMove = CCSequence:createWithTwoActions(leftOrRightMove, leftOrRightMove:reverse())
     	local repeatForever = CCRepeatForever:create(LeftRightMove)
     	local seq = CCSequence:createWithTwoActions(MoveToTop, CCCallFuncN:create(function(node)
               --node:removeAllActions()
     		node:removeFromParent()
     		
     	end))
     	bubbleSp:runAction(seq)
     	bubbleSp:runAction(repeatForever)
     end
     end, 3.0, false)
end

function StartScene:onEnter()
	-- body
end

function StartScene:onExit()
	CCDirector:sharedDirector():getScheduler():unscheduleScriptEntry(self._sharedScheduler)
end

return StartScene
