--
-- Author: gary
-- Date: 2014-11-27 14:59:56
--开始界面
local StartScene = class("StartScene", function ()
	return display.newScene()
end)
local size = CCDirector:sharedDirector():getWinSize()--设计分辨率


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


--创建鱼群和动画
function StartScene:createFish()
	local fish010 = CCSprite:createWithSpriteFrameName("fish010_01.png")--大鱼
	local fish08 = CCSprite:createWithSpriteFrameName("fish08_01.png")--海龟
	fish010:setPosition(ccp(-fish010:getContentSize().width/2,display.height-100))
	fish010:setFlipX(true)
	self._bgSp:addChild(fish010)
	fish08:setPosition(ccp(display.width+fish08:getContentSize().width/2,150))
	self._bgSp:addChild(fish08)
	--大鱼
	local frames010 = display.newFrames("fish010_0%d.png",1,9)
	local animation010 = display.newAnimation(frames010, 0.3)
	fish010:playAnimationForever(animation010,0.1)
	local move010 = CCMoveBy:create(10.0, ccp(display.width+fish010:getContentSize().width,0))
	local seq0101 = CCSequence:createWithTwoActions(move010, CCFlipX:create(false))
	local seq0102 = CCSequence:createWithTwoActions(move010:reverse(),CCFlipX:create(true))
	local seq01012 = CCSequence:createWithTwoActions(seq0101, seq0102)
	fish010:runAction(CCRepeatForever:create(seq01012))

	--海龟
	local frames08 = display.newFrames("fish08_0%d.png",1,9)
	local animation08 = display.newAnimation(frames08, 0.3)
	fish08:playAnimationForever(animation08,0.1)
	local move08 = CCMoveBy:create(15.0, ccp(-display.width-fish08:getContentSize().width,0))
	local seq0801 = CCSequence:createWithTwoActions(move08, CCFlipX:create(true))
	local seq0802 = CCSequence:createWithTwoActions(move08:reverse(),CCFlipX:create(false))
	local seq08012 = CCSequence:createWithTwoActions(seq0801, seq0802)
	fish08:runAction(CCRepeatForever:create(seq08012))
end


function StartScene:ctor()


    --背景音乐
    audio.playSound(ConstData.SEA_SOUNDS, true)

	--背景层,放置背景图片
	local bgLayer = display.newLayer()
	bgLayer:setScale(1.4)
	self._bgSp = display.newSprite(ConstData.START_BG)
	self._bgSp:setPosition(ccp(display.cx,display.cy))
	bgLayer:addChild(self._bgSp)
	self:addChild(bgLayer,0)
	self:bgAction()


    self:createFish()

	--泡泡 
	local sharedScheduler =  CCDirector:sharedDirector():getScheduler()
	self._sharedScheduler = sharedScheduler:scheduleScriptFunc(function()
	 local count = math.random(2,4)--5-10个泡泡
     for i = 0,count do
     	local pointX = math.random(60,140)--泡泡出生点的x
     	local pointY = math.random(-50,0)--泡泡出生点的y
     	local size = math.random()--0-1之间的数字
     	local bubbleSp = display.newSprite(ConstData.BUBBLE)
     	bubbleSp:setScale(size)
     	bubbleSp:setPosition(ccp(pointX,pointY))
     	self._bgSp:addChild(bubbleSp,1)

     	local MoveToTop = CCEaseExponentialIn:create(CCMoveTo:create(10.0, ccp(pointX,display.height)))
     	local leftOrRightMove = CCMoveBy:create(0.3, ccp(10,0))
     	local LeftRightMove = CCSequence:createWithTwoActions(leftOrRightMove, leftOrRightMove:reverse())
     	local repeatForever = CCRepeatForever:create(LeftRightMove)
     	local seq = CCSequence:createWithTwoActions(MoveToTop, CCCallFuncN:create(function(node)
     		node:removeFromParent()
     		
     	end))
     	bubbleSp:runAction(seq)
     	bubbleSp:runAction(repeatForever)
     end
     end, 3.0, false)


    --菜单回调函数
	local function onButtonClicked(tag)
		if tag == 1 then 
			print("开始游戏")
		elseif tag == 2 then
			print("游戏帮助")
		elseif tag == 3 then
			print("更多模式")
		end
	end
 	--菜单
 	local item1 = ui.newImageMenuItem({--开始游戏
 		image = ConstData.ENTER_GAME,
 		listener = onButtonClicked,
 		tag = 1
 		})
 	item1:setScale(0.9)
 	local item2 = ui.newImageMenuItem({--游戏帮助
 		image = ConstData.GAME_HELP,
 		listener = onButtonClicked,
 		tag = 2
 		})
 	item2:setScale(0.9)
	local item3 = ui.newImageMenuItem({--更多模式
		image = ConstData.MORE_MODE,
		listener = onButtonClicked,
		tag = 3
		})
	item3:setScale(0.9)
 	local menu = ui.newMenu({item1,item2,item3})
 	menu:alignItemsVerticallyWithPadding(25)
 	menu:setPosition(ccp(display.cx,display.cy))
 	self:addChild(menu)

 	--设置
 	local settingBtn = cc.ui.UIPushButton.new({normal = ConstData.GAME_SETTING},{scale9 = true})
 	settingBtn:setPosition(ccp(50,50))
 	settingBtn:onButtonClicked(function (event)
 	settingBtn:runAction(CCSequence:createWithTwoActions(CCScaleTo:create(0.3, 1.3), CCScaleTo:create(0.3, 1)))
 		print("设置")
 	end)

 	self:addChild(settingBtn)
 		   
end

function StartScene:onEnter()
	-- body
end

function StartScene:onExit()
	CCDirector:sharedDirector():getScheduler():unscheduleScriptEntry(self._sharedScheduler)
end

return StartScene
