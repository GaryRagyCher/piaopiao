--
-- Author: gary
-- Date: 2014-11-27 14:59:56
--开始界面
local StartScene = class("StartScene", function ()
	return display.newScene()
end)
require("app.ConstData")
local size = CCDirector:sharedDirector():getWinSize()--设计分辨率
local TAG_FISHANIMATIONLAYER = 10
local bubble_point1 = 100--泡泡出生点中心点1的x
local bubble_point2 = display.cx-100----泡泡出生中心点2的x


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

--随机泡泡
function StartScene:bubbleCreator()
     local point = math.random(bubble_point1-20,bubble_point1+20)--泡泡出生点的x
     local count = math.random(5,10)--5-10个泡泡
     local size = math.random()--0-1之间的数字
     print(point .. "**" .. count .. "**" .. size)
     for i = 0,count do
     	local bubbleSp = display.newSprite(BUBBLE)
     	bubbleSp:setScale(size)
     	bubbleSp:setPosition(ccp(point,100))
     	self._fishAnimationLayer:addChild(bubbleSp)
     	local MoveToTop = CCMoveBy:create(1.0, ccp(0,display.cy))
     	local leftOrRightMove = CCMoveBy:create(0.2, ccp(20,0))
     	local LeftRightMove = CCSequence:createWithTwoActions(leftOrRightMove, leftOrRightMove:reverse())
     	local repeatForever = CCRepeatForever:create(LeftRightMove)
     	bubbleSp:runAction(MoveToTop)
     	bubbleSp:runAction(repeatForever)
     end
end

function StartScene:ctor()
	--背景层,放置背景图片
	local bgLayer = display.newLayer()
	bgLayer:setScale(1.4)
	self._bgSp = display.newSprite(ConstData.START_BG)
	self._bgSp:setPosition(ccp(display.cx,display.cy))
	bgLayer:addChild(self._bgSp)
	self:addChild(bgLayer)
	self:bgAction()



	--动画层
	self._fishAnimationLayer =  display.newLayer()
	self._fishAnimationLayer:setTag(TAG_FISHANIMATIONLAYER)
	self._fishAnimationLayer:setPosition(ccp(display.cx,display.cy))
	self:addChild(self._fishAnimationLayer)
	--泡泡
	self:bubbleCreator()
	local bubbleSp = display.newSprite(BUBBLE)
	bubbleSp:setPosition(ccp(200,200))
	self._fishAnimationLayer:addChild(bubbleSp)


	

   
    --菜单层,用于放置菜单
    local menuLayer = display.newLayer()
    menuLayer:setPosition(ccp(display.cx,display.cy))
    self:addChild(menuLayer)
    
    
end



function StartScene:onEnter()
	-- body
end

function StartScene:onExit()
	-- body
end

return StartScene
