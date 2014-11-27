--
-- Author: qiushaiqiu
-- Date: 2014-11-27 11:39:18
--
module("ConstData", package.seeall)

--主角成长条件
GROWTH_CONDITION = {
	scene1 = {period1= 100, period2 = 200, period3 = 400},
	scene2 = {period1= 150, period2 = 400, period3 = 600},
	scene3 = {period1= 200, period2 = 600, period3 = 800},
	scene4 = {period1= 250, period2 = 800, period3 = 1000},
}


--鱼类拥有的金币数
FISH_GOLD = {
	fish_gold_small = 10,
	fish_gold_middle = 20,
	fish_gold_large = 50
}

--鱼类拥有的经验值
FISH_EXP = {
	scene1 = {fish_exp_small = 5, fish_exp_middle = 10, fish_exp_large = 40},
	scene2 = {fish_exp_small = 5, fish_exp_middle = 20, fish_exp_large = 60},
	scene3 = {fish_exp_small = 5, fish_exp_middle = 30, fish_exp_large = 80},
	scene4 = {fish_exp_small = 5, fish_exp_middle = 40, fish_exp_large = 100},
}


--背景图片
SCENE_BG = {
	scene1 = "sceneBG_1.png",
	scene2 = "sceneBG_2.png",
	scene3 = "sceneBG_3.png",
	scene4 = "sceneBG_4.png"
}

--资源加载界面
LOADING_BG = "loadingBG.png"

--开始界面
START_BG = "startBG.png"

--泡泡
BUBBLE = "bubble.png"